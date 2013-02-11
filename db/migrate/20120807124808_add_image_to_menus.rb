class AddImageToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :image_id, :integer
  end
end
