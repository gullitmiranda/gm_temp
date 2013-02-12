#encoding: utf-8

module RdcmsHelper
  # Menssagem de notificações
  def flash_message(options={})
    options = {
      close_button: true
      }.merge options

    messages = []
    button_close = "<button data-dismiss=\"alert\" class=\"close\" type=\"button\">×</button>" if options[:close_button]
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
    if bugherd_api.present? && user_mod.present? && role_mod.present? && eval("#{user_mod} && #{user_mod}.present? && #{user_mod}.has_role?('#{role_mod}')")
      render :partial => "posts/bugherd", :locals => {:bugherd_api => bugherd_api}
    end
  end

  def edit_post_link
    user_mod = Setting.for_key("rdcms.post.edit_link.user")
    role_mod = Setting.for_key("rdcms.post.edit_link.role")
    if user_mod.present? && role_mod.present? && eval("#{user_mod} && #{user_mod}.present? && #{user_mod}.has_role?('#{role_mod}')")
      render :partial => "/posts/edit_post_link"
    end
  end

  def basic_headers(options={})
    render :partial => "/posts/headers", :locals => {:options => options}
  end

  # Renderiza language selector
  def language_links(options={})
    links = []
    selector = []

    options[:dropdown  ] = defined?(options[:dropdown    ]) ? options[:dropdown    ] : true
    string    = defined?(options[:string    ]) ? options[:string    ] : true
    placement = defined?(options[:placement ]) ? options[:placement ] : "bottom"
     # data-placement="bottom"

    I18n.available_locales.each do |locale|
      locale_key  = "translation.#{locale}"
      span_key    = "<span class=\"text\">#{I18n.t(locale_key)}</span>"
      icon = "<i class=\"flag flag-#{locale}\"></i>"

      if options[:dropdown  ]
        if locale == I18n.locale
          selector << link_to('#', { class: "dropdown-toggle", :"data-toggle" => "dropdown", title: I18n.t(locale_key) }, rel: "tooltip", :"data-placement" => placement) do
            "#{icon} #{span_key}<span class=\"caret\"></span>".html_safe
          end
        else
          link = link_to("#{icon} #{span_key}</span>".html_safe, url_for(locale: locale.to_s))
          links << content_tag(:li, link).html_safe
        end
      else
        options = locale == I18n.locale ? { class: "active" } : {}
        options[:title] = I18n.t(locale_key) unless string
        options[:rel] = "tooltip"
        options[:"data-placement"] = placement

        link = link_to("#{icon} #{span_key}".html_safe, url_for(locale: locale.to_s))
        links << content_tag(:li, link, options).html_safe
      end
    end
    object_class = "nav nav-pills pull-right language_selector"
    object_class << " no_string" unless string

    if options[:dropdown  ]
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
      html << content_tag(:li, title: I18n.t(".social_pages.#{record.title}"), rel: "tooltip") do
        link_to("<i class=\"icon-#{record.title}\"></i>".html_safe, record.value, target: "_blank", rel: "publisher")
      end unless record.value.empty?
    end

    content_tag(:ul, html.html_safe, class: "follow_us")
  end

  # Renderiza o endereço formatado
  def render_address
    @companyName = Setting.get_object("rdcms.company.name")
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

    address.html_safe
  end

  # Renderiza o cabeçalho
  def render_header(setting_layout="application", preview=false, options={})
    setting_layout ||= "application"
    setting_name = "rdcms.view.#{setting_layout}"

    styleHeader = ""
    form        = ""
    style       = ""

    styleHeader << "position: relative;" if preview
    block = %Q{<div class="overlay-block"></div>} if preview

    # Application template
    if setting_layout == "application"
      @logo             = Setting.get_object("#{setting_name}.header.logo")
      @background       = Setting.get_object("#{setting_name}.header.background")
      @innerBackground  = Setting.get_object("#{setting_name}.header.inner_background")
      @padding          = Setting.get_object("#{setting_name}.header.padding")

      styleHeader << "background: #{@background.value};" unless @background.value.empty?
      styleHeader << "padding: #{@padding.value};" unless @padding.value.empty?

      style << "background: #{@innerBackground.value};" unless @innerBackground.value.empty?
      style << "#{options[:styles]}" unless options[:styles].blank?

    # Fullscreen
    elsif setting_layout == "full_screen"
      @logo   = Setting.get_object("#{setting_name}.logo")
    end

    noBlk   = @logo.uploads.last.blank?

    image = !noBlk ? @logo.uploads.last.upload(:logo) : @logo.value

    unless preview or setting_layout == "full_screen"
      nav = %Q{
            <div class="nav-collapse collapse">
              #{navigation_links.html_safe}
              #{language_links(options[:language]).html_safe}
            </div>}
    else
      form = %Q{<div id="updates" class="hidden">}
      form << %Q{#{best_in_place(@logo       , :upload_ids, type: :input, classes: "brand_logo", path: [:admin, @logo])} }

      form << %Q{
            #{best_in_place(@background , :value, type: :input, classes: "background", path: [:admin, @background])}
            #{best_in_place(@innerBackground, :value, type: :input, classes: "innerBackground", path: [:admin, @innerBackground])}
      } if setting_layout == "application"

      form << %Q{</div>}
    end

    brand = link_to("/#{I18n.locale.to_s}/", class: "brand", title: I18n.t(".back_to_homepage"), rel: "tooltip") do
      html = image_tag(image, :class => "logo")
      html
    end

    inner_html = %Q{
    <div class="navbar #{setting_layout} #{"navbar navbar-fixed-top navbar-fade-background" if options[:fixed] == true}">
      <div class="navbar-inner nav-colorize" style="#{styleHeader}">
        <div class="container nav-background" style="#{style}">
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
  def render_footer(setting_layout="application", preview=false, options={})
    setting_layout = "application" if defined?(setting_layout)
    setting_name = "rdcms.view.#{setting_layout}"

    isApplication = setting_name == "rdcms.view.application"

    if isApplication
      # Data objetos com algumas informações da companhia
      @companyName  = Setting.get_object("rdcms.company.name")
      @companyPhone = Setting.get_object("rdcms.company.phone")
      @companyEmail = Setting.get_object("rdcms.company.email")
      @companyYear  = Setting.get_object("rdcms.company.year")

      phone = "<em>#{I18n.t('attributes_all.phone'        )}: #{@companyPhone.value}</em><br>" unless @companyPhone.value.empty?
      email = "<em>#{I18n.t('attributes_all.contact_email')}: <a href=\"mailto:#{@companyEmail.value}\">#{@companyEmail.value}</a></em>" unless @companyEmail.value.empty?

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
        <footer class="#{setting_layout}" #{"style=\"position: relative;\"" if preview}>
          <div class="footer-box nav-background" style="#{footerStyle}">
            <div class="footer-container" style="#{footerContainerStyle}">
              <div class="container">
                <div class="row">
                  <div class="span4">
                    <h4>#{t("layouts.#{setting_layout}.contact")}</h4>
                    <address>
                      <p>#{render_address}</p>
                      #{phone}
                      #{email}
                    </address>
                  </div>
                  <div class="span4">
                    <h4>#{t("layouts.#{setting_layout}.pages")}</h4>

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
                        <div class="newsletter_form">
                          <p class="description">#{t("layouts.#{setting_layout}.newsletter_description")}.</p>
                          #{render :template => "newsletters/new"}
                        </div>
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
                  <em>#{t("layouts.#{setting_layout}.copyright", :company => @companyName.value, :year => @companyYear.value)}</em>
                </div>
                <div class="developer span4">
                  #{t("layouts.#{setting_layout}.developed_by")}:
                  <a title="Requestdev Sistemas" class="developer-logo" href="http://www.requestdev.com.br" rel="tooltip" data-placement="top">
                    <img alt="Requestdev Sistemas" src="http://requestdev.com.br/images/requestdev_developer.png">
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
