#encoding: utf-8

module RdcmsHelper
  # Menssagem de notificações
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

  # Error explanation
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
  
  # alias para Setting.for_key(name)
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
  # Renderiza language selector
  def language_links(options={})
    links = []
    selector = []

    dropdown  = defined?(options[:dropdown ]) ? options[:dropdown ] : true
    string    = defined?(options[:string   ]) ? options[:string   ] : true

    I18n.available_locales.each do |locale|
      locale_key  = "translation.#{locale}"
      span_key    = "<span class=\"text\">#{I18n.t(locale_key)}</span>"
      icon = "<i class=\"flag flag-#{locale}\"></i>"

      if dropdown
        if locale == I18n.locale
          selector << link_to('#', { class: "dropdown-toggle", :"data-toggle" => "dropdown", title: I18n.t(locale_key) }) do
            "#{icon} #{span_key}<span class=\"caret\"></span>".html_safe
          end
        else
          link = link_to("#{icon} #{span_key}</span>".html_safe, url_for(locale: locale.to_s))
          links << content_tag(:li, link).html_safe
        end
      else
        options = locale == I18n.locale ? { class: "active" } : {}
        options[:title] = I18n.t(locale_key) unless string

        link = link_to("#{icon} #{span_key}".html_safe, url_for(locale: locale.to_s))
        links << content_tag(:li, link, options).html_safe
      end
    end
    object_class = "nav nav-pills pull-right language_selector"
    object_class << " no_string" unless string

    if dropdown
      dropdown = content_tag(:ul, links.join("\n").html_safe, class: "dropdown-menu")
      selector = content_tag(:li, selector.join("\n").html_safe + dropdown, { class: "dropdown" })
    else
      selector = links.join("\n").html_safe
    end
    content_tag(:ul, selector, class: "#{object_class}")
  end

  # Renderiza botões de curti nas redes sociais
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

  # Renderiza botões de páginas das redes sociais
  def social_pages_buttons
    # Botões das redes sociais
    @social_pages = Setting.get_object("rdcms.social_pages")
    html = ""
    @social_pages.children.each do |record|
      html << content_tag(:li, target: "_blank") do
        link_to("<i class=\"icon-#{record.title}\"></i>".html_safe, record.value)
      end unless record.value.empty?
    end

    content_tag(:ul, html.html_safe, class: "follow_us")
  end


  # Renderiza o cabeçalho
  def render_header(setting_name="rdcms.view.application", preview=false, options={})
    setting_name = "rdcms.view.application" if defined?(setting_name)

    @logo             = Setting.get_object("#{setting_name}.header.logo")
    @background       = Setting.get_object("#{setting_name}.header.background")
    @innerBackground  = Setting.get_object("#{setting_name}.header.inner_background")
    @padding          = Setting.get_object("#{setting_name}.header.padding")

    noBlk   = @logo.uploads.last.blank?

    image = !noBlk ? @logo.uploads.last.upload(:logo) : @logo.value

    unless preview
      nav = %Q{
            <div class="nav-collapse collapse">
              #{navigation_links.html_safe}
              #{language_links(options[:language]).html_safe}
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
      html
    end

    styleHeader = ""
    styleHeader << "background: #{@background.value};" unless @background.value.empty?
    styleHeader << "padding: #{@padding.value};" unless @padding.value.empty?
    styleHeader << "position: relative;" if preview

    style = ""
    style << "background: #{@innerBackground.value};" unless @innerBackground.value.empty?
    style << "#{options[:styles]}" unless options[:styles].blank?

    block = %Q{<div class="overlay-block"></div>} if preview

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
          #{nav}
          #{form}
        </div>
        #{block}
      </div>
    </div>}

    inner_html.html_safe
  end

  # Renderiza o rodapé
  def render_footer(setting_name="rdcms.view.application", preview=false, options={})
    setting_name = "rdcms.view.application" if defined?(setting_name)

    isApplication = setting_name == "rdcms.view.application"

    # Nome da companhia
    @companyName = Setting.get_object("rdcms.company.name")

    if isApplication
      # Informações da companhia
      @companyAddress = Setting.get_object("rdcms.company.address")
      @companyDistrict = Setting.get_object("rdcms.company.district")
      @companyCep = Setting.get_object("rdcms.company.cep")
      @companyCity = Setting.get_object("rdcms.company.city")
      @companyState = Setting.get_object("rdcms.company.state")
      @companyCountry = Setting.get_object("rdcms.company.country")
      @companyPhone = Setting.get_object("rdcms.company.phone")
      @companyEmail = Setting.get_object("rdcms.company.email")

      # Dados a serem exibidos sobre a companhia
      address = ""
      address = "<strong>#{@companyName.value}</strong><br>" unless @companyName.value.empty?
      address << "#{@companyAddress.value}<br>" unless @companyAddress.value.empty?
      address << "#{@companyDistrict.value}" unless @companyDistrict.value.empty?
      address << ", CEP: #{@companyCep.value}" unless @companyCep.value.empty?
      address << "<br>" if !@companyDistrict.value.empty? or !@companyCep.value.empty?
      address << "#{@companyCity.value}" unless @companyCity.value.empty?
      address << " - #{@companyState.value}" unless @companyState.value.empty?
      address << ", #{@companyCountry.value}" unless @companyCountry.value.empty?

      phone = "<em>#{I18n.t('atributes_all.phone'        )}: #{@companyPhone.value}</em><br>" unless @companyPhone.value.empty?
      email = "<em>#{I18n.t('atributes_all.contact_email')}: <a href=\"mailto:#{@companyEmail.value}\">#{@companyEmail.value}</a></em>" unless @companyEmail.value.empty?

      # Objetos da Estilização
      @footerBackground           = Setting.get_object("#{setting_name}.footer.background")
      @footerPadding              = Setting.get_object("#{setting_name}.footer.padding")
      @footerContainerBackground  = Setting.get_object("#{setting_name}.footer.container_background")

      # Simula form quando for preview
      if preview
        form = %Q{
              <div id="updates" class="hidden">
                #{best_in_place(@footerBackground , :value, type: :input, classes: "footerBackground", path: [:admin, @footerBackground])}
                #{best_in_place(@footerContainerBackground, :value, type: :input, classes: "footerContainerBackground", path: [:admin, @footerContainerBackground])}
              </div>
        }
      end

      footerStyle = ""
      footerStyle << "background: #{@footerBackground.value};" unless @footerBackground.value.empty?
      footerStyle << "padding: #{@footerPadding.value};" unless @footerPadding.value.empty?

      footerContainerStyle = ""
      footerContainerStyle << "background: #{@footerContainerBackground.value};" unless @footerContainerBackground.value.empty?
      footerContainerStyle << "#{options[:styles]}" unless options[:styles].blank?

      return html = %Q{
        <footer #{"style=\"position: relative;\"" if preview}>
          <div class="footer-box green-sea" style="#{footerStyle}">
            <div class="footer-container" style="#{footerContainerStyle}">
              <div class="container">
                <div class="row">
                  <div class="span4">
                    <h4>#{t('.contact')}</h4>
                    <address>
                      <p>#{address}</p>
                      #{phone}
                      #{email}
                    </address>
                  </div>
                  <div class="span4">
                    <h4>#{t('.pages')}</h4>

                    #{navigation_links "nav"}
                    <ul class="nav">
                      <li>#{link_to t("menu_nav.login"), admin_root_path, target: "_blank"}</li>
                    </ul>
                  </div>
                  <div class="span4">
                    <div class="row">
                      <div class="span4">#{social_pages_buttons}</div>
                    </div>
                    <div class="row">
                      <div class="span4 newsletter">
                        <p class="description">#{t('.newsletter_description')}.</p>
                        #{render :template => "newsletters/new"}
                      </div>
                    </div>
                  </div>
                  #{form}
                </div>
              </div>
            </div>
          </div>
          <div class="copyright_developer">
            <div class="container">
              <div class="row">
                <div class="copyright span8">
                  <em>#{t('.copyright', :company => "Valeria Totti", :year => "2012")}</em>
                </div>
                <div class="developer span4">
                  #{t('.developed_by')}:
                  <a title="Requestdev Sistemas" class="developer-logo" href="http://www.requestdev.com.br">
                    <img alt="Requestdev Sistemas" src="http://requestdev.com.br/images/Logo 204x48.png">
                  </a>
                </div>
              </div>
            </div>
          </div>
        #{"<div class=\"overlay-block\"></div>".html_safe if preview}
        </footer>
      }.html_safe
    else
      return html = %Q{}.html_safe
    end
  end
end
