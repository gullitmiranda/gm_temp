ActiveAdmin.register Slider do
  menu  priority: 3,
        parent: proc{ I18n.t('activerecord.models.content_management') },
        if: proc{can?(:update, Slider)}
  # menu false

  index do
    render :partial => "admin/slider", :locals => { :admin => true }
  end

  show do
    render :partial => "show", locals: { :s => slider }
  end

  form :partial => "form"

  batch_action :destroy, false
  config.clear_sidebar_sections!
end
