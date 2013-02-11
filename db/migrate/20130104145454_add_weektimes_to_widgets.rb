class AddWeektimesToWidgets < ActiveRecord::Migration
  def change
    remove_column :widgets, :offline_time_start
    remove_column :widgets, :offline_time_end
    add_column :widgets, :offline_time_week_start_end, :text
  end
end
