class CreateProductsUploads < ActiveRecord::Migration
  def change
    create_table :rdcms_products_uploads do |t|
      t.references :rdcms_product, :rdcms_upload
      t.string :position

      t.timestamps
    end
  end
end
