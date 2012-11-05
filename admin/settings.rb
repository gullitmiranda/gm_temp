ActiveAdmin.register Setting  do
  menu  priority: 5,
        parent: I18n.t('activerecord.models.settings'),
        if: proc{can?(:update, Setting)}
  # 
  menu false;

  controller.authorize_resource :class => Setting
  scope "Werte", :with_values, :default => true

  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Allgemein" do
      f.input :title
      f.input :value
      f.input :parent_id, :as => :select, :collection => Setting.all.map{|c| [c.title, c.id]}, :include_blank => true
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :title do |setting|
      link_to "#{setting.parent_names}.#{setting.title}", edit_admin_setting_path(setting)
    end
    column :value
  end

  sidebar :overview, only: [:index]  do
    render :partial => "/admin/shared/overview", :object => Setting.roots, :locals => {:link_name => "title", :url_path => "setting" }
  end

  batch_action :destroy, false

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
      link_to("Undo", revert_admin_setting_path(:id => resource.versions.last), :class => "undo")
    end
  end

end
