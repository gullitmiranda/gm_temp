# DEPRECATION WARNING: ActiveAdmin::Dashboard is deprecated and will be removed in the next version
ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }


  content :title => proc{ I18n.t "active_admin.dashboard_header" } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span "Welcome to admin panel."
        # small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
      end
    end

    # columns do
    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    # Recents
    columns do
      column do
        panel "Recent Products" do
          @products = Rdcms::Product.all(:order => 'updated_at DESC', :limit => 5)
          if @products.blank?
            div :class => "blank_slate_container" do
              div :class => "blank_slate" do
                span I18n.t("active_admin.blank_slate.content", resource_name: Rdcms::Product.model_name.human)
                small link_to(I18n.t('active_admin.new_model', model: Rdcms::Product.model_name.human), new_admin_product_path)
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
      column do
        panel "Recent Posts" do
          @posts = Post.all(:order => 'datetime DESC', :limit => 5)
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
    end # end Recents
    # Sliders
    columns do
      column do
        panel "Sliders" do
          div class:"attributes_table well align-center" do
            render :partial => "admin/slider", :locals => { :admin => true }
          end
        end
      end
    end
  end # content

# ActiveAdmin::Dashboards.build do
  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
   # section I18n.t('last_updated_articles', scope: [:dashboard_sections, :active_admin]), priority: 1, :if => proc{can?(:update, Rdcms::Article)} do
   #  table do
   #    tr do
   #      [t(:title, scope: [:activerecord, :attributes, "rdcms/article"]), t(:updated_at, scope: [:activerecord, :attributes, "rdcms/article"]), t(:edit, scope: :active_admin)].each do |sa|
   #        th sa
   #      end
   #    end

   #    Rdcms::Article.recent(5).collect do |article|
   #      tr do
   #        td article.title
   #        td l(article.updated_at, format: :short)
   #        td link_to(t(:edit), admin_article_path(article))
   #      end
   #    end
   #  end
   # end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section 'last_updated_articles', :priority => 1
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
