class AddOfflineSetterToRdcmsWidgets < ActiveRecord::Migration
  def change
    add_column :rdcms_widgets, :offline_days, :string
    add_column :rdcms_widgets, :offline_time_start, :datetime
    add_column :rdcms_widgets, :offline_time_end, :datetime
  end
end
