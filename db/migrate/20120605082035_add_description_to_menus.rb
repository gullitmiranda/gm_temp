class AddDescriptionToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :description, :text
    add_column :menus, :call_to_action_name, :string
  end
end
