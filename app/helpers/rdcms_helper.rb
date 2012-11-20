#encoding: utf-8

module RdcmsHelper
  
  def language_links
    links = []
    selector = []
    I18n.available_locales.each do |locale|
      locale_key = "translation.#{locale}"
      icon = "<i class=\"flag flag-#{locale}\"></i>"
      
      if locale == I18n.locale
        selector << link_to('#', { class: "dropdown-toggle", :"data-toggle" => "dropdown" }) do
          "#{icon} #{I18n.t(locale_key)}<span class=\"caret\"></span>".html_safe
        end
      else
        link = link_to("#{icon} #{I18n.t(locale_key)}".html_safe, url_for(locale: locale.to_s))
        links << content_tag(:li, link).html_safe
      end
    end
    dropdown = content_tag(:ul, links.join("\n").html_safe, class: "dropdown-menu")
    selector = content_tag(:li, selector.join("\n").html_safe + dropdown, { class: "dropdown" })
    content_tag(:ul, selector, class: "nav nav-pills pull-right")
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
end
