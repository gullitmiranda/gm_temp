class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :source
      t.string :rights
      t.text :description
      t.string :upload_file_name
      t.string :upload_content_type
      t.integer :upload_file_size
      t.integer :attachable_id
      t.string :attachable_type
      t.string :alt_text

      t.timestamps
    end
    add_index :uploads, :upload_file_name
  end
end
