# encoding: utf-8

class PostsController < ApplicationController
  include ExtendPostsController

  # load_and_authorize_resource
  #authorize_resource

  layout "application"
  before_filter :check_format
  before_filter :geocode_ip_address, only: [:show]

  if Setting.for_key("rdcms.post.cache_posts") == "true"
    caches_action :show, :cache_path => :show_cache_path.to_proc, :if => proc {@post && @post.present? && is_cachable?  }
  end

  respond_to :html, :json
  def index
    @posts = Post.active
    respond_with @posts
  end

  def show
    ActiveSupport::Notifications.instrument("rdcms.post.show", :params => params)
    before_init

    if serve_iframe?
      respond_to do |format|
        format.html { render layout: "/rdcms/bare_layout" }
      end
    elsif serve_basic_post?
      initialize_post(@post)
      Post.load_liquid_methods(location: session[:user_location], post: @post, params: params)

      load_associated_model_into_liquid() if can_load_associated_model?
      after_init()

      if generate_index_list?
        @list_of_posts = get_posts_by_post_type
        include_related_models()
        get_posts_with_tags() if @post.index_of_posts_tagged_with.present?
        get_posts_without_tags() if @post.not_tagged_with.present?
        get_posts_by_frontend_tags() if params[:frontend_tags].present?
        sort_response()
        after_index()
      end

      if serve_fresh_page?
        set_expires_in()
        ActiveSupport::Notifications.instrument("rdcms.post.render", :params => params)
        before_render()
        respond_to do |format|
          format.html { render layout: choose_layout() }
          format.rss
          format.json do
            @post["list_of_posts"] = @list_of_posts
            render json: @post.to_json
          end
        end
      end
    elsif should_statically_redirect?
      redirect_to @post.external_url_redirect
    elsif should_dynamically_redirect?
      redirect_dynamically()
    else
      # Render 404 Post if no Post else is found
      redirect_to_404()
    end
  end

  def show_cache_path
    geo_cache = Setting.for_key("rdcms.geocode_ip_address") == "true" && session[:user_location].present? && session[:user_location].city.present? ? session[:user_location].city.parameterize.underscore : "no_geo"
    date_cache = Setting.for_key("rdcms.post.max_cache_24h") == "true" ? Date.today.strftime("%Y%m%d") : "no_date"
    art_cache = @post ? @post.cache_key : "no_art"
    user_cache = current_user.present? ? current_user.id : "no_user"

    "g/#{geo_cache}/#{user_cache}/#{date_cache}/#{params[:post_id]}/#{art_cache}_#{params[:pdf]}_#{params[:frontend_tags]}__#{params[:iframe]}"
  end

  def convert_to_pdf
    if @post
      require 'net/http'
      require "uri"
      uid = Setting.for_key("rdcms.html2pdf_uid")
      uri = URI.parse("http://html2pdf.ikusei.de/converter/new.xml?&print_layout=true&uid=#{uid}&url=#{@post.absolute_public_url}#{CGI::escape('?pdf=1')}")
      logger.debug(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      doc = Nokogiri::HTML(response.body)
      file = doc.at_xpath("//file-name").text
      redirect_to "http://html2pdf.ikusei.de#{file}"
    else
      render :text => "404", :status => 404
    end
  end

  def sitemap
    if Setting.for_key("rdcms.use_ssl") == "true"
      @use_ssl = "s"
    else
      @use_ssl = ""
    end
    @domain_name = Setting.for_key("rdcms.url")
    @posts = Post.for_sitemap
    #TODO: authorize! :read, @post
    respond_to do |format|
      format.xml
    end
  end

  private
  # ------------------ Redirection ------------------------------------------
  def redirect_dynamically
    target_post = @post.find_related_subpost
    if target_post.present?
      redirect_to target_post.public_url
    else
      redirect_to_404
    end
  end

  def should_statically_redirect?
    @post && @post.external_url_redirect.present?
  end

  def should_dynamically_redirect?
    @post && !(@post.dynamic_redirection == "false")
  end

  def redirect_to_404
    ActiveSupport::Notifications.instrument("rdcms.post.not_found", :params => params)
    @post = Post.find_by_name("404")
    if @post
      respond_to do |format|
        format.html { render :layout => @post.selected_layout, :status => 404 }
      end
    elsif File.exists?(File.join(::Rails.root,"public","404.html"))
      render file: 'public/404', layout: false
    else
      render :text => "404", :status => 404
    end
  end

  # ------------------ associated models ------------------------------------
  def can_load_associated_model?
    @post.post_type.present? && @post.post_type_form_file != "Default" && @post_type = @post.send(@post.post_type_form_file.downcase.to_sym)
  end

  def load_associated_model_into_liquid
    Post::LiquidParser["#{@post.post_type_form_file.downcase}"] = @post_type
  end

  def include_related_models
    @list_of_posts = @list_of_posts.includes("#{@post.post_type_form_file.downcase}") if @post.respond_to?(@post.post_type_form_file.downcase)
  end
  # ------------------ /associated models -----------------------------------

  # ------------------ choose post to render -----------------------------
  def generate_index_list?
    @post.post_type.present? && @post.kind_of_post_type.downcase == "index"
  end

  def serve_iframe?
    @post && params["iframe"].present? && params["iframe"] == "true"
  end

  def serve_basic_post?
    @post && @post.external_url_redirect.blank? && @post.dynamic_redirection == "false"
  end

  def serve_fresh_page?
    !is_cachable? || stale?(last_modified: @post.date_of_last_modified_child, etag: @post.id)
    # If the request is stale according to the given timestamp and etag value
    # (i.e. it needs to be processed again) then execute this block
    #
    # If the request is fresh (i.e. it's not modified) then you don't need to do
    # anything. The default render checks for this using the parameters
    # used in the previous call to stale? and will automatically send a
    # :not_modified.  So that's it, you're done.
    #
  end

  def choose_layout
    params[:pdf] && params[:pdf].present? && params[:pdf] == "1" ? "pdf" : "application"
  end
  # ------------------ /choose post to render ----------------------------

  # ------------------ adjust response --------------------------------------
  def sort_response
    if @post.sort_order.present?
      if @post.sort_order == "Random"
        @list_of_posts = @list_of_posts.flatten.shuffle
      elsif @post.sort_order == "Alphabetical"
        @list_of_posts = @list_of_posts.flatten.sort_by{|post| post.title }
      elsif @post.respond_to?(@post.sort_order)
        sort_order = @post.sort_order.downcase
        @list_of_posts = @list_of_posts.flatten.sort_by{|post| post.respond_to?(sort_order) ? post.send(sort_order) : post }
      elsif @post.sort_order.include?(".")
        sort_order = @post.sort_order.downcase.split(".")
        @unsortable = @list_of_posts.flatten.select{|a| !a.respond_to_all?(@post.sort_order) }
        @list_of_posts = @list_of_posts.flatten.delete_if{|a| !a.respond_to_all?(@post.sort_order) }
        @list_of_posts = @list_of_posts.sort_by{|a| eval("a.#{@post.sort_order}") }
        if @unsortable.count > 0
          @list_of_posts = @unsortable + @list_of_posts
          @list_of_posts = @list_of_posts.flatten
        end
      end
      if @post.reverse_sort
        @list_of_posts = @list_of_posts.reverse
      end
    end

    if @post.sorter_limit && @post.sorter_limit > 0
      @list_of_posts = @list_of_posts[0..@post.sorter_limit-1]
    end
  end

  def get_posts_with_tags
    @list_of_posts = @list_of_posts.tagged_with(@post.index_of_posts_tagged_with.split(",").map{|t| t.strip}, on: :tags, any: true)
  end

  def get_posts_without_tags
    @list_of_posts = @list_of_posts.tagged_with(@post.not_tagged_with.split(",").map{|t| t.strip}, :exclude => true, on: :tags)
  end

  def get_posts_by_frontend_tags
    @list_of_posts = @list_of_posts.tagged_with(params[:frontend_tags], on: :frontend_tags, any: true)
  end

  def get_posts_by_post_type
    @list_of_posts = Post.active.posttype("#{@post.post_type_form_file} Show")
  end

  def set_expires_in
    if is_cachable?
      expires_in 30.seconds, :public => true
      response.last_modified = @post.date_of_last_modified_child
    else
      expires_in 1.seconds, :public => true
      response.last_modified = Time.now
    end
  end

  def set_format
    if params[:post_id].present? && params[:post_id].include?(".")
      params[:format] = params[:post_id].split('.').last
    end
  end
  # ------------------ /adjust response -------------------------------------

  def post_by_role
    # Admin should get preview of post even if it's offline
    if current_user && current_user.has_role?(Setting.for_key("rdcms.post.preview.roles").split(",").map{|a| a.strip})
      @post = Post.search_by_url(params[:post_id])
    else
      post = Post.active.search_by_url(params[:post_id])
      operator = current_user || current_visitor
      a = Ability.new(operator)
      if a.can?(:read, post)
        @post = post
      end
    end
  end

  def check_format
    if request.format == "image/jpeg"  || request.format == "image/png"
      render :text => "404", :status => 404
    end
  end

  def geocode_ip_address
    if ActiveRecord::Base.connection.table_exists?("settings")
      if Setting.for_key("rdcms.geocode_ip_address") == "true"
        if session[:user_location].blank?
          #Geokit::Geocoders::MultiGeocoder.geocode("194.39.218.11") schlägt fehl (Completed 500 Internal Server Error) daher...
          begin
              @ip_result = Geokit::Geocoders::MultiGeocoder.geocode(request.remote_ip)
              session[:user_location] = @ip_result
          rescue Exception => e
            logger.error("***********")
            logger.error(e)
            @ip_result = nil
          end
          if @ip_result.present? && @ip_result.city.present?
            Post::LiquidParser["user_location"] = @ip_result.city
          else
            Post::LiquidParser["user_location"] = "Ji-Paraná"
          end
        else
          Post::LiquidParser["user_location"] = session[:user_location].city
        end
      end
    end
  end

  def is_cachable?
    if Setting.for_key("rdcms.post.cache_posts") == "true" && @post.cacheable
      #Wenn es einen current_user gibt, dann kein caching
      Devise.mappings.keys.each do |key|
        if eval("current_#{key.to_s}.present?")
          return false
        end
      end
      return true
    else
      return false
    end
  end

  def initialize_post(current_post)
    Post::LiquidParser["current_post"] = @post

    set_meta_tags :site => s("rdcms.site.name"),
                  :title => current_post.metatag("Title Tag"),
                  :description => current_post.metatag("Meta Description"),
                  :keywords => current_post.metatag("Keywords"),
                  # :canonical => current_post.canonical_url,
                  # :noindex => current_post.robots_no_index,
                  :open_graph => {:title => current_post.metatag("OpenGraph Title"),
                                :description => current_post.metatag("OpenGraph Description"),
                                :type => current_post.metatag("OpenGraph Type"),
                                :url => current_post.metatag("OpenGraph URL"),
                                :image => current_post.metatag("OpenGraph Image")}
  end
end
