class ChangeDefaultTypeToWidgets < ActiveRecord::Migration
  def change
    change_column :widgets, :default, :boolean

  end
end
