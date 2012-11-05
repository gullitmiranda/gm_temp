class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.string :slug
      t.string :name
      t.datetime :datetime
      t.text :description

      t.timestamps
    end
    add_index :galleries, :name, :unique => true
    add_index :galleries, :slug, :unique => true
    
    Gallery.create_translation_table! :name => :string, :description => :text
  end

  def down
    drop_table :galleries
    Gallery.drop_translation_table!
  end
end
