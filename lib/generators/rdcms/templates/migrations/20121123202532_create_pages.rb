class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string :slug
      t.string :name
      t.text :content
      t.boolean :in_menu, :default => false
      t.boolean :published, :default => false

      t.timestamps
    end
    add_index :pages, :slug, :unique => true
    add_index :pages, :name, :unique => true

    Page.create_translation_table! :name => :string, :content => :text
  end

  def down
    drop_table :pages
    Page.drop_translation_table!
  end
end
