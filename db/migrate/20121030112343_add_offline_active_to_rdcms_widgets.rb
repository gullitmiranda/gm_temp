class AddOfflineActiveToRdcmsWidgets < ActiveRecord::Migration
  def change
    add_column :rdcms_widgets, :offline_time_active, :boolean
  end
end
