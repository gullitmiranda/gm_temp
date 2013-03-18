module PostsHelper

  # 'Read on' link to post for index-pages
  # If external_url_redirect is set and a link_title is given,
  # display this link title. Otherwise display a generic link title.
  def read_on(post)
    if post.redirect_link_title.present?
      link_to post.redirect_link_title, post.external_url_redirect, class: 'more'
    else
      link_to t(:read_on, scope: [:posts]), post.public_url, class: 'more'
    end
  end

  def render_post_content_parts(post)
    render :partial => "/posts/show", :locals => {:post => post}
  end

  # def render_post_image_gallery
  #   if @post
  #     result = ""
  #     uploads = Upload.tagged_with(@post.image_gallery_tags.present? ? @post.image_gallery_tags.split(",") : "" )
  #     if uploads && uploads.count > 0
  #       uploads.order(:sorter_number).each do |upload|
  #         result << content_tag("li", link_to(image_tag(upload.image.url(:thumb), {alt: upload.alt_text}), upload.image.url(:large), title: raw(upload.description)))
  #       end
  #     end
  #     return content_tag("ul", raw(result), :class => "post_image_gallery")
  #   end
  # end

  def navigation_menu(menu_id, options={})
    return "id can't be blank" if menu_id.blank?
    #0 = unlimited, 1 = self, 2 = self and children 1. grades, 3 = self and up to children 2.grades
    depth = options[:depth] || 0
    class_name = options[:class] || ""
    id_name = options[:id] || ""
    if menu_id.class == String
      master_menu = Menu.active.find_by_title(menu_id)
    else
      master_menu = Menu.active.find_by_id(menu_id)
    end

    if master_menu.present?
      content = ""
      master_menu.children.active.includes(:image).collect do |child|
        content << navigation_menu_helper(child, depth, 1, options)
      end
      if id_name.present?
        result = content_tag(:ul, raw(content),:id => "#{id_name}", :class => "#{class_name} #{depth} navigation #{master_menu.css_class.to_s.gsub(/\W/,' ')}".squeeze(' ').strip)
      else
        result = content_tag(:ul, raw(content), :class => "#{class_name} #{depth} navigation #{master_menu.css_class.to_s.gsub(/\W/,' ')}".squeeze(' ').strip)
      end
    end
    return raw(result)
  end

  def breadcrumb(options={})
    id_name = options[:id] || "breadcrumb"
    class_name = options[:class] || ""
    if @post
      list = ""
      @post.path.each do |art|
        link_name = link_to(art.breadcrumb_name, art.public_url)
        list << content_tag(:li, raw(link_name))
      end
      content_list = content_tag(:ol, raw(list))
      if id_name.present?
        result = content_tag(:nav, raw(content_list), :id => "#{id_name}", :class => "#{class_name}")
      else
        result = content_tag(:nav, raw(content_list), :class => "#{class_name}")
      end
      return raw(result)
    end
  end

  def index_of_posts(options={})
    if @post && @post.post_for_index_id.present? && master_index_post = Post.find_by_id(@post.post_for_index_id)
      result_list = ""
      result_list += content_tag(:h2, raw("&nbsp;"), class: "boxheader")
      result_list += content_tag(:h1, "#{master_index_post.title}", class: "headline")
      dom_element = (options[:wrapper]).present? ? options[:wrapper] : :div
      master_index_post.descendants.order(:created_at).limit(@post.post_for_index_limit).each do |art|
        if @post.post_for_index_levels.to_i == 0 || (@post.depth + @post.post_for_index_levels.to_i > art.depth)
          rendered_post_list_item = render_post_list_item(art)
          result_list += content_tag(dom_element, rendered_post_list_item, :id => "post_index_list_item_#{art.id}", :class => "post_index_list_item")
        end
      end
      return content_tag(:post, raw(result_list), :id => "post_index_list")
    end
  end

  def render_post_type_content(options={})
    if @post && @post.post_type.present? && @post.kind_of_post_type.present?
      render :partial => "posttypes/#{@post.post_type_form_file.downcase}/#{@post.kind_of_post_type.downcase}"
    else
      render :partial => "posttypes/default/show"
    end
  end

  # def render_post_widgets(options={})
  #   custom_css = options[:class] || ""
  #   tags = options[:tagged_with] || ""
  #   default = options[:default] || "false"
  #   widget_wrapper = options[:wrapper] || "section"
  #   result = ""
  #   if @post
  #     widgets = @post.widgets.active
  #     if tags.present? && default == "false"
  #       widgets = widgets.tagged_with(tags.split(","))
  #     elsif default == true && tags.present?
  #       widgets = Widget.active.where(:default => true).tagged_with(tags.split(","))
  #     else
  #       widgets = widgets.where(:tag_list => "")
  #     end
  #     widgets = widgets.order(:sorter)

  #     widgets.each do |widget|
  #       template = Liquid::Template.parse(widget.content)
  #       alt_template = Liquid::Template.parse(widget.alternative_content)
  #       html_data_options = {"class" => "#{widget.css_name} #{custom_css} rdcms_widget",
  #                             "id" => widget.id_name.present? ? widget.id_name : "widget_id_#{widget.id}",
  #                             'data-date-start' => widget.offline_date_start_display,
  #                             'data-date-end' => widget.offline_date_end_display,
  #                             'data-offline-active' => widget.offline_time_active,
  #                             'data-id' => widget.id
  #                           }
  #       html_data_options = html_data_options.merge(widget.offline_time_week)
  #       result << content_tag(widget_wrapper, raw(template.render(Post::LiquidParser)), html_data_options)
  #       result << content_tag(widget_wrapper, raw(alt_template.render(Post::LiquidParser)),
  #                     class: "#{widget.css_name} #{custom_css} hidden rdcms_widget",
  #                     id: widget.id_name, 'data-id' => widget.id)
  #     end
  #   end
  #   return raw(result)
  # end

  private

  def render_post_list_item(post_item)
    result = ""
    result += content_tag(:div, link_to(post_item.title, post_item.public_url), :class=> "title")
    result += content_tag(:div, post_item.created_at.strftime("%d.%m.%Y %H:%M"), :class=>"created_at")
    if @post.post_for_index_images == true && post_item.images.count > 0
      result += content_tag(:div, image_tag(post_item.images.first.image(:thumb)), :class => "post_image")
    end
    result += content_tag(:div, raw(post_item.public_teaser), :class => "teaser")
    result += content_tag(:div, link_to(s("rdcms.post.post_index.link_to_post"), post_item.public_url), :class=> "link_to_post")
    return raw(result)
  end

  def navigation_menu_helper(child, depth, current_depth, options)
    child_link = content_tag(:a, child.title, :href => child.target.gsub("\"",''))
    image_link = child.image.present? ? image_tag(child.image.image(:original)) : ""
    child_link = child_link + content_tag(:a, image_link, :href => child.target.gsub("\"",''), :class => "navigtion_link_imgage_wrapper") unless options[:show_image] == false
    child_link = child_link + content_tag(:a, child.description_title, :href => child.target.gsub("\"",''), :class => "navigtion_link_description_title") unless options[:show_description_title] == false
    template = Liquid::Template.parse(child.description)
    child_link = child_link + content_tag("div", raw(template.render(Post::LiquidParser)), :class => "navigtion_link_description") unless options[:show_description] == false
    child_link = child_link + content_tag(:a, child.call_to_action_name, :href => child.target.gsub("\"",''), :class => "navigtion_link_call_to_action_name") unless options[:show_call_to_action_name] == false
    current_depth = current_depth + 1
    if child.children && (depth == 0 || current_depth <= depth)
      content_level = ""
      child.children.active.each do |subchild|
          content_level << navigation_menu_helper(subchild, depth, current_depth, options)
      end
      if content_level.present?
        child_link = child_link + content_tag(:ul, raw(content_level), :class => "level_#{current_depth} children_#{child.children.active.count}" )
      end
    end
    return content_tag(:li, raw(child_link),"data-id" => child.id , :class => "#{child.has_active_child?(request) ? 'has_active_child' : ''} #{child.is_active?(request) ? 'active' : ''} #{child.css_class.gsub(/\W/,' ')}".squeeze(' ').strip)
  end
end
