class CreateSettingsUploads < ActiveRecord::Migration
  def change
    create_table :settings_uploads do |t|
      t.references :setting, :upload
    end
  end
end
