class AddSorterToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :sorter_id, :integer, :default => 0
  end
end
