class CreateProductsUploads < ActiveRecord::Migration
  def change
    create_table :products_uploads do |t|
      t.references :product, :upload
      t.string :position

      t.timestamps
    end
  end
end
