class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :slug
      t.string :name
      t.text :body
      t.datetime :datetime
      t.integer :position
      t.integer :object_type
      t.boolean :published, :default => false
      t.string :ancestry

      t.string :publication_file_name
      t.string :publication_content_type
      t.integer :publication_file_size

      t.timestamps
    end

    add_index :publications, :name
    add_index :publications, :ancestry
    add_index :publications, :slug, :unique => true
    
    Publication.create_translation_table! :name => :string, :body => :text
  end

  def down
    remove_index :publications, :name
    remove_index :publications, :ancestry
    remove_index :publications, :slug

    drop_table :publications
    Publication.drop_translation_table!
  end
end
