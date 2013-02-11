class AddSorterToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :sorter, :integer

  end
end
