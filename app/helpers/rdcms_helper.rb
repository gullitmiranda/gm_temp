#encoding: utf-8

module RdcmsHelper
  
  def language_links
    links = []
    selector = []
    I18n.available_locales.each do |locale|
      locale_key = "translation.#{locale}"
      icon = "<i class=\"flag flag-#{locale}\"></i>"
      
      if locale == I18n.locale
        selector << link_to('#', { class: "dropdown-toggle", :"data-toggle" => "dropdown", title: I18n.t(locale_key) }) do
          "#{icon} <span class=\"text\">#{I18n.t(locale_key)}</span><span class=\"caret\"></span>".html_safe
        end
      else
        link = link_to("#{icon} #{I18n.t(locale_key)}".html_safe, url_for(locale: locale.to_s))
        links << content_tag(:li, link).html_safe
      end
    end
    dropdown = content_tag(:ul, links.join("\n").html_safe, class: "dropdown-menu")
    selector = content_tag(:li, selector.join("\n").html_safe + dropdown, { class: "dropdown" })
    content_tag(:ul, selector, class: "nav nav-pills pull-right language_selector")
  end

  def flash_message
    messages = []
    button_close = "<button data-dismiss=\"alert\" class=\"close\" type=\"button\">×</button>"
    [:notice, :info, :warning, :error].each {|type|
      classtype = case type
        when :notice then "success"
        else type
      end
      if flash[type]
        messages << content_tag(:div, "#{button_close}#{flash[type]}".html_safe, class: "alert alert-#{classtype}")
      end
    }

    # messages.html_safe
    content_tag(:div, messages.join("\n").html_safe, class: "flash_message_container")
  end

  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div id=\"error_explanation\" class=\"alert alert-error #{object.class.name.humanize.downcase}Errors'>\n"
      html << "\t<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button>\n"
      if message.blank?
        html << "\t<h2>#{pluralize(f.object.errors.count, "error")} prohibited this product from being saved:</h2>"
      else
        html << "<h2>#{message}</h2>"
      end  
      html << "\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t<li>#{error}</li>\n"
      end
      html << "\t</ul>\n"
      html << "</div>\n"
    end
    html
  end  
  
  def social_buttons_json
    data = {
      "twitter" => {
        "data-via" => "#{Setting.for_key("rdcms.twitter.via")}",
        "data-rel" => "#{Setting.for_key("rdcms.twitter.rel")}",
        "data-hash" => "#{Setting.for_key("rdcms.twitter.hash")}",
        "data-lang" => I18n.locale
      }
    }
    data.to_json
  end

  def s(name)
    if name.present?
      Setting.for_key(name)
    end
  end

  def bugtracker
    user_mod = Setting.for_key("rdcms.bugherd.user")
    role_mod = Setting.for_key("rdcms.bugherd.role")
    bugherd_api = Setting.for_key("rdcms.bugherd.api")
    if bugherd_api.present? && user_mod.present? && role_mod.present? && eval("#{user_mod} && #{user_mod}.has_role?('#{role_mod}')")
      render :partial => "articles/bugherd", :locals => {:bugherd_api => bugherd_api}
    end
  end

  def render_header(setting_name="rdcms.view.application", preview=false, options={})
    setting_name = "rdcms.view.application" if defined?(setting_name)

    @logo             = Setting.get_object("#{setting_name}.logo")
    @background       = Setting.get_object("rdcms.view.application.background")
    @innerBackground  = Setting.get_object("rdcms.view.application.inner-background")

    noBlk   = @logo.uploads.last.blank?

    image = !noBlk ? @logo.uploads.last.upload(:logo) : Setting.for_key("#{setting_name}.logo")

    unless preview
      nav = %Q{
            <div class="nav-collapse collapse">
              #{navigation_links.html_safe}
              #{language_links.html_safe}
            </div>}
    else
      form = %Q{
            <div id="updates" class="hidden">
              #{best_in_place(@logo       , :upload_ids, type: :input, classes: "brand_logo", path: [:admin, @logo])}
              #{best_in_place(@background , :value, type: :input, classes: "background", path: [:admin, @background])}
              #{best_in_place(@innerBackground, :value, type: :input, classes: "innerBackground", path: [:admin, @innerBackground])}
            </div>
      }
    end

    brand = link_to(root_path, :class => "brand") do
      html = image_tag(image, :class => "logo")
      # html << best_in_place(@logo, :upload_ids, type: :input, classes: "hidden", path: [:admin, @logo]) if preview
      html
    end

    styleHeader = ""
    styleHeader << "background: #{@background.value}" if @background.value

    style = ""
    style << "background: #{@innerBackground.value};" if @innerBackground.value
    style << "#{options[:styles]}"

    inner_html = %Q{
    <div class="navbar">
      <div class="navbar-inner nav-colorize" style="#{styleHeader}">
        <div class="container green-sea" style="#{style}">
          <a class="btn btn-navbar" data-target=".nav-collapse" data-toggle="collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>

          #{brand}
          #{nav or ""}
          #{form or ""}
        </div>
      </div>
    </div>}

    inner_html.html_safe
  end
end
