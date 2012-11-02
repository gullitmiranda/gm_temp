class CreateRdcmsUploads < ActiveRecord::Migration
  def change
    create_table :rdcms_uploads do |t|
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
    add_index :rdcms_uploads, :upload_file_name
  end
end
