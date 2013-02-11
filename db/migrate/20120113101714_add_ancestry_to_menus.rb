class AddAncestryToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :ancestry, :string
    add_index :menus, :ancestry
  end
end
