class AddPolyToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :locateable_type, :string
    add_column :locations, :locateable_id, :integer
  end
end
