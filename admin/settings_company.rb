ActiveAdmin.register_page "company" do
  menu  priority: 2, label: I18n.t('activerecord.models.company'),
        parent: I18n.t('activerecord.models.settings')

  content title: I18n.t('activerecord.models.company') do
    render :partial => "admin/settings/company"#, locals: { :s => gallery }
  end
end