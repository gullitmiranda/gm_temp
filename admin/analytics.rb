ActiveAdmin.register_page "analytics" do
  menu  priority: 4,
        label: proc{ I18n.t('activerecord.models.analytics.other') },
        parent: proc{ I18n.t('activerecord.models.settings') }

  content title: I18n.t('activerecord.models.analytics.other') do
    render :partial => "admin/analytics/google"
  end
end
