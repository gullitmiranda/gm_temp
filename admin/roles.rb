ActiveAdmin.register Role do
  menu  priority: 2,
        parent: proc{ I18n.t('activerecord.models.settings') },
        if: proc{can?(:update, Role)}
  #
  menu false;

  controller.authorize_resource :class => Role
end
