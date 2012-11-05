class CreateGalleriesUploads < ActiveRecord::Migration
  def change
    create_table :galleries_uploads do |t|
      t.references :gallery, :upload
      t.string :position

      t.timestamps
    end
  end
end
