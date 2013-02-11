class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.string :target
      t.string :css_class
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
