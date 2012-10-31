class AddTitleToRdcmsLocations < ActiveRecord::Migration
  def change
    add_column :rdcms_locations, :title, :string
  end
end
