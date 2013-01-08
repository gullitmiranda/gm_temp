class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :slug
      t.string :name
      t.text :description
      t.text :url
      t.integer :position
      t.boolean :published, :default => false

      t.string :partner_file_name
      t.string :partner_content_type
      t.integer :partner_file_size

      t.timestamps
    end

    add_index :partners, :name
    add_index :partners, :slug, :unique => true

    Partner.create_translation_table! :description => :text
  end

  def down
    remove_index :partners, :name
    remove_index :partners, :slug

    drop_table :partners
    Partner.drop_translation_table!
  end
end
