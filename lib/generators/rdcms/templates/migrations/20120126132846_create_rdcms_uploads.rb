class CreateRdcmsUploads < ActiveRecord::Migration
  def change
    create_table :rdcms_uploads do |t|
      t.string :source
      t.string :rights
      t.text :description
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.integer :attachable_id
      t.string :attachable_type
      t.string :alt_text

      t.timestamps
    end
    add_index :uploads, :upload_file_name
  end
end
