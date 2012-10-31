ActiveAdmin.register Rdcms::Permission, :as => "Permission" do
  menu  priority: 3,
        label: proc{ I18n.t "activerecord.models.#{Rdcms::Permission.model_name.human.downcase}.other" },
        parent: I18n.t('activerecord.models.settings'),
        if: proc{can?(:update, Rdcms::Permission)}
  # 
  controller.authorize_resource :class => Rdcms::Permission

  index do
    selectable_column
    column "Role", sortable: :role do |permission|
      permission.role.name
    end
    column :action
    column :subject_class
    column :subject_id
    default_actions
  end

  form html: {enctype: "multipart/form-data"} do |f|
    f.actions
    f.inputs do
      f.input :role_id, as: :select, collection: Rdcms::Role.all.map{|role| [role.name.capitalize, role.id]}, include_blank: false
      f.input :action
      f.input :subject_class
      f.input :subject_id
    end
    f.actions
  end
end
