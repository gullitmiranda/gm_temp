ActiveAdmin.register_page "visualization" do
  menu  priority: 2,
        label: I18n.t('activerecord.models.visualization'),
        parent: I18n.t('activerecord.models.settings')

  content title: I18n.t('activerecord.models.visualization') do
    render :partial => "admin/settings/visualization"#, locals: { :s => gallery }
  end
end
