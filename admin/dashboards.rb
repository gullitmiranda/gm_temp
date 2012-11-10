# DEPRECATION WARNING: ActiveAdmin::Dashboard is deprecated and will be removed in the next version
ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }


  content :title => proc{ t ".dashboard_header" } do
  # content :title => proc{ I18n.t "active_admin.dashboard_header" } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        # small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
      end
    end

    # Recentes
    ## Row #1 - [Produtos, Artigos, Newsletter]
    columns do
      # Produtos Recentes
      column do
        panel I18n.t("rdcms.recent_products") do
          @products = Product.recents(Setting.for_key("rdcms.dashboard.limit_itens"))
          if @products.blank?
            div :class => "blank_slate_container" do
              div :class => "blank_slate" do
                span I18n.t("active_admin.blank_slate.content", resource_name: Product.model_name.human)
                small link_to(I18n.t('active_admin.new_model', model: Product.model_name.human), new_admin_product_path)
              end
            end
          else
            ul do
              @products.map do |object|
                li link_to(object.name, admin_product_path(object))
              end
            end
          end
        end
      end
      # Artigos Recentes
      column do
        panel I18n.t("rdcms.recent_posts") do
          @posts = Post.recents(Setting.for_key("rdcms.dashboard.limit_itens"))
          if @posts.blank?
            div :class => "blank_slate_container" do
              div :class => "blank_slate" do
                span I18n.t("active_admin.blank_slate.content", resource_name: Post.model_name.human)
                small link_to(I18n.t('active_admin.new_model', model: Post.model_name.human), new_admin_post_path)
              end
            end
          else
            ul do
              @posts.map do |object|
                li link_to(object.name, admin_post_path(object))
              end
            end
          end
        end
      end
      # Novas Assinaturas
      column do
        panel I18n.t("rdcms.recent_entries") do
          @newsletters = Newsletter.recents(Setting.for_key("rdcms.dashboard.limit_itens"))
          if @newsletters.blank?
            div :class => "blank_slate_container" do
              div :class => "blank_slate" do
                span I18n.t("active_admin.blank_slate.content", resource_name: Newsletter.model_name.human)
                small link_to(I18n.t('active_admin.new_model', model: Newsletter.model_name.human), new_admin_newsletter_path)
              end
            end
          else
            ul do
              @newsletters.map do |object|
                li link_to("#{object.name} <#{object.email}>", admin_newsletter_path(object))
              end
            end
          end
        end
      end
    end # end Row #1
    ## Row #2 - [Sliders, Galerias]
    columns do
      column do
        panel I18n.t("rdcms.published_sliders") do
          div class:"attributes_table well align-center" do
            render :partial => "admin/slider", :locals => { :admin => true }
          end
        end
      end
      column do
        panel I18n.t("rdcms.recent_galleries") do
          div class:"attributes_table well" do
            # render :partial => "admin/slider", :locals => { :admin => true }
          end
        end
      end
    end # end Row #2
  end # content
end
