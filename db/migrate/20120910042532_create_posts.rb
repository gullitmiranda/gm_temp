class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :slug
      t.string :name
      t.text :body
      t.datetime :datetime
      t.text :summary
      t.string :ancestry
      t.boolean :published, :default => false

      t.string :posts_file_name
      t.string :posts_content_type
      t.integer :posts_file_size

      t.timestamps
    end
    add_index :posts, :name, :unique => true
    add_index :posts, :slug, :unique => true
    add_index :posts, :ancestry

    Post.create_translation_table! :name => :string, :body => :text, :summary => :text
  end

  def down
    drop_table :posts
    Post.drop_translation_table!
  end
end
