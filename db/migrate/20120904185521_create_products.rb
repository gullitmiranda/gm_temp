class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
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
    add_index :products, :name, :unique => true
    add_index :products, :slug, :unique => true

    Product.create_translation_table! :name => :string, :description => :text
  end

  def down
    drop_table :products
    Product.drop_translation_table!
  end
end
