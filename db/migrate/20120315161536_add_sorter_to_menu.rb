class AddSorterToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :sorter, :integer, :default => 0
  end
end
