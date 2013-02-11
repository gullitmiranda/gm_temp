class AddTeaserTitleToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :description_title, :string
  end
end
