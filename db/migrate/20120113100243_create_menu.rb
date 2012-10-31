class CreateMenues < ActiveRecord::Migration
  def change
    create_table :rdcms_menu do |t|
      t.string :title
      t.string :target
      t.string :css_class
      t.boolean :active, :default => true

      t.string :ancestry
      t.integer :sorter, :default => 0
      t.text :description
      t.string :call_to_action_name
      t.string :description_title
      t.integer :image_id

      t.timestamps
    end

    add_index :rdcms_menu, :ancestry
  end
end
