ActiveAdmin.register Rdcms::Role, :as => "Role" do
  menu  priority: 2,
        label: proc{ I18n.t "activerecord.models.#{Rdcms::Role.model_name.human.downcase}.other" },
        parent: I18n.t('activerecord.models.settings'),
        if: proc{can?(:update, Rdcms::Role)}
  # 
  controller.authorize_resource :class => Rdcms::Role
end