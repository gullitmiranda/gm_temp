class CreateProducts < ActiveRecord::Migration
  def up
    create_table :rdcms_products do |t|
      t.string :slug
      t.string :name
      t.text :description
      t.decimal :price , :precision => 10, :scale => 2
      t.decimal :length, :precision => 10, :scale => 2
      t.decimal :width , :precision => 10, :scale => 2
      t.decimal :height, :precision => 10, :scale => 2
      t.decimal :weight, :precision => 10, :scale => 3

      t.timestamps
    end
    add_index :rdcms_products, :name, :unique => true
    add_index :rdcms_products, :slug, :unique => true

    Rdcms::Product.create_translation_table! :name => :string, :description => :text
  end

  def down
    drop_table :rdcms_products
    Rdcms::Product.drop_translation_table!
  end
end
