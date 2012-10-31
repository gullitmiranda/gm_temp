class ChangeDefaultTypeToRdcmsWidgets < ActiveRecord::Migration
  def change
    remove_column :rdcms_widgets, :default
    add_column :rdcms_widgets, :default, :boolean
  end
end