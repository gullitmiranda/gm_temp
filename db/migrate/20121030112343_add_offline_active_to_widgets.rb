class AddOfflineActiveToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :offline_time_active, :boolean
  end
end
