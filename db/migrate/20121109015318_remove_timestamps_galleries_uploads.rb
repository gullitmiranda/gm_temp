class RemoveTimestampsGalleriesUploads < ActiveRecord::Migration
  def change
    change_table :galleries_uploads do |t|
      t.remove_timestamps
    end
  end
end
