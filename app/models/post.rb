include ApplicationHelper

class Post < ActiveRecord::Base
  attr_accessible :datetime, :name, :summary, :body, :published,
    # Slug, I18n e tags
    :slug, :locale, :translations_attributes, :tag_list,
    # Paperclip
    :posts, :posts_content_type, :posts_file_name, :posts_file_size

  has_attached_file :posts, :styles => { :thumb => "260x180#" },
                    :convert_options => { :all => '-auto-orient -quality 70 -interlace Plane' }

  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  MetatagNames = ["Title Tag", "Meta Description", "Keywords", "OpenGraph Title", "OpenGraph Description", "OpenGraph Type", "OpenGraph URL", "OpenGraph Image"]
  LiquidParser = {}
  SortOptions = ["Created_at", "Updated_at", "Random", "Alphabetically"]
  DynamicRedirectOptions = [[:false,"disabled"],[:latest,"latest subentry"], [:oldest, "eldest subentry"]]
  attr_accessor   :hint_label

  # Associações
  has_many :metatags
  has_many :comments
  has_many :permissions, :foreign_key => "subject_id", :conditions => {:subject_class => "Post"}

  # Atributos aninhados
  accepts_nested_attributes_for :metatags, :allow_destroy => true, :reject_if => proc { |attributes| attributes['value'].blank? }
  accepts_nested_attributes_for :permissions, :allow_destroy => true

  # Escopos
  scope :active, where(:published => true)
  scope :inactive, where(:published => false)
  scope :recents, lambda{ |limit = 10| visible.order("datetime desc").limit(limit)}
  # avoid bug
  scope :visible, where(:published => true)

  # URl externa para redirecionamento
  web_url         :external_url_redirect

  # Versionamento dos models
  has_paper_trail

  # Renderização de modelos seguros
  liquid_methods :name, :summary, :body, :created_at, :updated_at

  # Translate
  translates :name, :body, :summary
  accepts_nested_attributes_for :translations

  class Translation
    attr_accessible :locale, :name, :body, :summary
  end
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
    set_translations new_translations
  end

  # Taggings
  acts_as_taggable
  # acts_as_taggable_on :tags, :frontend_tags #https://github.com/mbleigh/acts-as-taggable-on

=begin
  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
=end

  # Contador de visitas
  is_visitable accept_ip: true

  # Callbacks
  after_create :set_active_since
  after_create :notification_event_create
  after_update :notification_event_update
  after_save :verify_existence_of_opengraph_image
  after_save :set_default_opengraph_values
  before_save :set_url_name_if_blank

  # Instance Methods
  # **************************
  def respond_to_all?(method_name)
    begin
      return eval("self.#{method_name}.present?")
    rescue
      return false
    end
  end

  #dynamic methods for post.event or post.consultant .... depending on related object type
  def method_missing(meth, *args, &block)
    if meth.to_s.split(".").first == self.get_related_object.class.name.downcase
        if meth.to_s.split(".").count == 1
          self.get_related_object
        else
          self.get_related_object.send(meth.to_s.split(".").last)
        end
    else
      super
    end
  end

  def set_active_since
    self.active_since = self.created_at
  end

  def complete_json

  end

  def self.active
    Post.where("published = true AND active_since < '#{Time.now.utc}'")
  end

  def self.load_liquid_methods(options={})

  end

  def notification_event_create
    ActiveSupport::Notifications.instrument("rdcms.post.created", :post_id => self.id)
  end

  def notification_event_update
    ActiveSupport::Notifications.instrument("rdcms.post.updated", :post_id => self.id)
  end

  # Tipos de artigos
  # **************************
  # Gets the related object by post_type
  def get_related_object
    if self.post_type.present? && self.post_type_form_file.present? && self.respond_to?(self.post_type_form_file.downcase)
      return self.send(self.post_type_form_file.downcase)
    else
      return nil
    end
  end

  # Exibe Consultor | Filial | etc. dependendo do tipo de página
  def post_type_form_file
    self.post_type.split(" ").first if self.post_type.present?
  end

  # Retorna índice ou mostrar, dependendo do tipo de página
  def kind_of_post_type
    self.post_type.present? ? self.post_type.split(" ").last : ""
  end

  # Retorna os nomes das categorias, independente de pagina de visualização ou de indice
  def post_type_for_search
    if self.post_type.present?
      self.post_type.split(" ").first
    else
      "Post"
    end
  end

  def self.post_types_for_select
    results = []
    path_to_posttypes = File.join(::Rails.root, "app", "views", "posttypes")
    if Dir.exist?(path_to_posttypes)
      Dir.foreach(path_to_posttypes) do |name| #.map{|a| File.basename(a, ".html.erb")}.delete_if{|a| a =~ /^_edit/ }.delete_if{|a| a[0] == "_"}
        file_name_path = File.join(path_to_posttypes,name)
        if File.directory?(file_name_path)
          Dir.foreach(file_name_path) do |sub_name|
              file_name = "#{name}#{sub_name}" if File.exist?(File.join(file_name_path,sub_name)) && (sub_name =~ /^_(?!edit).*/) == 0
              results << file_name.split(".").first.to_s.titleize if file_name.present?
          end
        end
      end
    end
    return results
  end

  def self.post_types_for_search
    results = []
    path_to_posttypes = File.join(::Rails.root, "app", "views", "posttypes")
    if Dir.exist?(path_to_posttypes)
      Dir.foreach(path_to_posttypes) do |name| #.map{|a| File.basename(a, ".html.erb")}.delete_if{|a| a =~ /^_edit/ }
        results << name.capitalize unless name.include?(".")
      end
    end
    return results
  end

  # Breadcrumb
  # **************************
  def breadcrumb_name
    # if self.breadcrumb.present?
    #   return self.breadcrumb
    # else
      return self.name
    # end
  end

  # URL
  # **************************
  def public_url
    url_for controller: "posts", action: "show", only_path: true
    # post_path(s)
    # post_path(self)
    # self.path
    # "/#{self.path.select([:ancestry, :url_name, :startpage]).map{|a| a.url_name if !a.startpage}.compact.join("/")}"
  end

  def absolute_public_url
    if Setting.for_key("rdcms.use_ssl") == "true"
      "https://#{Setting.for_key('rdcms.url')}#{self.public_url}"
    else
      "http://#{Setting.for_key('rdcms.url')}#{self.public_url}"
    end
  end

  # OpenGraph
  # **************************
  def verify_existence_of_opengraph_image
    if Metatag.where("post_id = ? AND name = 'OpenGraph Image'", self.id).count == 0
      Metatag.create( post_id: self.id,
                      name: "OpenGraph Image",
                      value: Setting.for_key("rdcms.facebook.opengraph_default_image"))
    end

    if self.posts?
      meta_tag = Metatag.where(post_id: self.id, name: "OpenGraph Image").first
      meta_tag.value = "#{self.posts(:thumb).to_s}"
      meta_tag.save
    end
  end

  def set_default_opengraph_values
    if Metatag.where(post_id: self.id, name: 'OpenGraph Title').none?
      Metatag.create( name: 'OpenGraph Title',
                      post_id: self.id,
                      value: self.name)
    end

    if Metatag.where(post_id: self.id, name: 'OpenGraph URL').none?
      Metatag.create( name: 'OpenGraph URL',
                      post_id: self.id,
                      value: self.absolute_public_url)
    end

    if Metatag.where(post_id: self.id, name: 'OpenGraph Description').none?
      if self.summary.present?
        value = self.summary
      else
        value = self.body.present? ? self.body.truncate(200) : self.name
      end
      Metatag.create( name: 'OpenGraph Description',
                      post_id: self.id,
                      value: value)
    end
  end

  # Metatag
  # **************************
  def metatag(name)
    return "" if !MetatagNames.include?(name)
    metatag = self.metatags.find_by_name(name)
    metatag.value if metatag
  end

  # Pesquisa
  # **************************
  # Especifica uma cadeia de texto a ser pesquisado no artigo
  def searchable_in_post_type
    @searchable_in_post_type_result ||= begin
      related_object = self.get_related_object
      if related_object && related_object.respond_to?(:fulltext_searchable_text)
        related_object.fulltext_searchable_text
      else
        " "
      end
    end
  end

  # Cache
  # **************************
  def self.recreate_cache
    if RUBY_VERSION.include?("1.9.")
      PostsCacheWorker.perform_async()
    else
      Post.active.each do |post|
        post.updated_at = Time.now
        post.save
      end
    end
  end
end

#parent           Returns the parent of the record, nil for a root node
#parent_id        Returns the id of the parent of the record, nil for a root node
#root             Returns the root of the tree the record is in, self for a root node
#root_id          Returns the id of the root of the tree the record is in
#is_root?         Returns true if the record is a root node, false otherwise
#ancestor_ids     Returns a list of ancestor ids, starting with the root id and ending with the parent id
#ancestors        Scopes the model on ancestors of the record
#path_ids         Returns a list the path ids, starting with the root id and ending with the node's own id
#path             Scopes model on path records of the record
#children         Scopes the model on children of the record
#child_ids        Returns a list of child ids
#has_children?    Returns true if the record has any children, false otherwise
#is_childless?    Returns true is the record has no childen, false otherwise
#siblings         Scopes the model on siblings of the record, the record itself is included
#sibling_ids      Returns a list of sibling ids
#has_siblings?    Returns true if the record's parent has more than one child
#is_only_child?   Returns true if the record is the only child of its parent
#descendants      Scopes the model on direct and indirect children of the record
#descendant_ids   Returns a list of a descendant ids
#subtree          Scopes the model on descendants and itself
#subtree_ids      Returns a list of all ids in the record's subtree
#depth            Return the depth of the node, root nodes are at depth 0

