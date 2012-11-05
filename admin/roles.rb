ActiveAdmin.register Role do
  menu  priority: 2,
        parent: I18n.t('activerecord.models.settings'),
        if: proc{can?(:update, Role)}
  # 
  controller.authorize_resource :class => Role
  menu false;
end