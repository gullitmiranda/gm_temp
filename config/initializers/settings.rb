require 'rdcms/acts_as_setting'
Rails.application.config.to_prepare do
  if ActiveRecord::Base.connection.table_exists?("rdcms_settings")
    Rdcms::Setting.import_default_settings(Rdcms::Engine.root + "config/settings.yml")
  end
end
