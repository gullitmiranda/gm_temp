class AddOfflineSetterToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :offline_days, :string
    add_column :widgets, :offline_time_start, :datetime
    add_column :widgets, :offline_time_end, :datetime
  end
end
