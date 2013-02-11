class AddTitleToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :title, :string
  end
end
