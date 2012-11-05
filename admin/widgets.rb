ActiveAdmin.register Widget do
  menu  priority: 4,
        parent: I18n.t('activerecord.models.content_management'),
        if: proc{can?(:read, Widget)}
  # 
  # menu false;

  scope "Alle", :scoped, :default => true
  scope "online", :active
  scope "offline", :inactive
  scope "defaults", :default

  if ActiveRecord::Base.connection.table_exists?("tags")
    Widget.tag_counts_on(:tags).map(&:name).each do |wtag|
      scope(I18n.t(wtag, :scope => [:rdcms, :widget_types], :default => wtag)){ |t| t.tagged_with(wtag) }
    end
  end

  form html: { enctype: "multipart/form-data" } do |f|
    f.actions
    f.inputs "Allgemein" do
      f.input :title
      f.input :content
      f.input :mobile_content
      f.input :id_name
      f.input :css_name
      f.input :teaser
      f.input :sorter, :hint => "Nach dieser Nummer wird sortiert: Je h&ouml;her, desto weiter unten in der Ansicht"
      f.input :tag_list
      f.input :active
    end
    f.inputs "Darstellung" do
      f.input :offline_day, as: :check_boxes, collection: Widget::OfflineDays
      f.input :offline_time_start, as: :string, hint: I18n.t(:offline_time_start_hint, scope: [:activerecord, :attributes, 'widget']), input_html: { value: (f.object.offline_time_start.strftime("%H:%M") if f.object.offline_time_start.present?) }
      f.input :offline_time_end, as: :string, hint:  I18n.t(:offline_time_end_hint, scope: [:activerecord, :attributes, 'widget']), input_html: { value: (f.object.offline_time_end.strftime("%H:%M") if f.object.offline_time_end.present?) }
      f.input :offline_time_active, hint: 'Soll dieses Widget zeitgesteuert sichtbar sein?'
      f.input :alternative_content, hint: 'Dieser Inhalt wird angezeigt, wenn das Widget offline ist.'
    end
    f.inputs "Admin" do
      if(proc{can?(:read, Widget)})
        f.input :default, :hint => "Bestimmt ob ein Widget immer und auf jeder Seite angezeigt wird oder nicht."
      end
      f.input :description
    end
    f.inputs "Artikel" do
      f.input :articles, :as => :select, :collection => Article.find(:all, :order => "title ASC"), :input_html => { :class => 'chzn-select'}
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :title
    column :id_name
    column :css_name
    column :active, :sortable => :active do |widget|
      widget.active ? "online" : "offline"
    end
    column :sorter
    column :tag_list, :sortable => false
    column :default, :sortable => :default do |widget|
      widget.default ? "default" : "no default"
    end
    column "" do |widget|
      result = ""
      result += link_to(t(:edit), edit_admin_widget_path(widget), :class => "member_link edit_link edit", :title => "bearbeiten")
      result += link_to(t(:delete), admin_widget_path(widget), :method => :DELETE, :confirm => t("delete_article", :scope => [:rdcms, :flash_notice]), :class => "member_link delete_link delete", :title => "loeschen")
      raw(result)
    end
  end

  show :title => :title do
    panel "Widget" do
      attributes_table_for widget do
        [:title, :content, :css_name, :active].each do |a|
          row a
        end
      end
    end
    panel "Articles" do
      table do
        tr do
          ["Title", "url_name"].each do |ta|
            th ta
          end
        end
        widget.articles.each do |wa|
          tr do
            [wa.title, wa.url_name].each do |watd|
              td watd
            end
          end
        end
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

  batch_action :destroy, false

  action_item :only => :edit do
    if resource.versions.last
      link_to("Undo", revert_admin_widget_path(:id => resource.versions.last), :class => "undo")
    end
  end

  controller do
    def show
      show! do |format|
         format.html { redirect_to edit_admin_widget_path(@widget), :flash => flash }
      end
    end
  end


end
