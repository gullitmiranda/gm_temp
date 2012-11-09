class RemoveTimestampsProductsUploads < ActiveRecord::Migration
  def change
    change_table :products_uploads do |t|
      t.remove_timestamps
    end
  end
end
