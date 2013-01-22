ActiveAdmin.register Menu do
  menu  priority: 2,
        label: Menu.model_name.human.pluralize,
        parent: proc{ I18n.t('activerecord.models.content_management') },
        if: proc{can?(:read, Menu)}
  #
  menu false;

  controller.authorize_resource :class => Menu

  form do |f|
    f.actions
    f.inputs "Allgemein" do
      f.input :title
      f.input :target
      f.input :parent_id, :as => :select, :collection => Menu.all.map{|c| ["#{c.path.map(&:title).join(" / ")}", c.id]}.sort{|a,b| a[0] <=> b[0]}, :include_blank => true
    end
    f.inputs "Optionen" do
      f.input :sorter, :hint => "Nach dieser Nummer wird sortiert: Je h&ouml;her, desto weiter unten in der Ansicht"
      f.input :active
      f.input :css_class
    end

    f.inputs "Details" do
      f.input :image, :as => :select, :collection => Upload.all.map{|c| [c.complete_list_name, c.id]}, :input_html => { :class => 'article_image_file chzn-select-deselect', :style => 'width: 70%;', 'data-placeholder' => 'Bild auswaehlen' }, :label => "Bild ausw&auml;hlen"
      f.input :description_title
      f.input :description, :input_html => { :rows => 5}
      f.input :call_to_action_name
    end
      f.actions
  end

  index do
    selectable_column
    column :id
    column :title
    column :target
    column :active
    column :sorter
    column "Artikel" do |menu|
      if menu.mapped_to_article?
        link_to("search", admin_articles_path("q[url_name_contains]" => menu.target.to_s.split('/').last))
      else
        link_to("create one", new_admin_article_path(:article => {:title => menu.title, :url_name => menu.target.to_s.split('/').last}))
      end
    end
    column "" do |menu|
      result = ""
      result += link_to("View", admin_menu_path(menu), :class => "member_link view_link view", :title => "Vorschau")
      result += link_to("Edit", edit_admin_menu_path(menu), :class => "member_link edit_link edit", :title => "bearbeiten")
      result += link_to("New Submenu", new_admin_menu_path(:parent => menu), :class => "member_link edit_link", :class => "new_subarticle", :title => "neues Untermenue")
      result += link_to("Delete", admin_menu_path(menu), :method => :DELETE, :confirm => "Realy want to delete this Menuitem?", :class => "member_link delete_link delete", :title => "loeschen")
      raw(result)
    end
  end

  sidebar :overview, only: [:index] do
    render :partial => "/admin/shared/overview", :object => Menu.order(:title).roots, :locals => {:link_name => "title", :url_path => "menu", :order_by => "title" }
  end

  batch_action :destroy, false


  controller do
    def new
      @menu = Menu.new(params[:menu])
      if params[:parent] && params[:parent].present?
        @parent = Menu.find(params[:parent])
        @menu.parent_id = @parent.id
      end
    end
  end

  member_action :revert do
    @version = Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end
    redirect_to :back, :notice => "Undid #{@version.event}"
  end

  action_item :only => :edit do
    if resource.versions.last
      link_to("Undo", revert_admin_menu_path(:id => resource.versions.last), :class => "undo")
    end
  end

  controller do
    def show
      show! do |format|
         format.html { redirect_to edit_admin_menu_path(@menu), :flash => flash }
      end
    end
  end
end
