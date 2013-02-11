class AddNameToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :id_name, :string

  end
end
