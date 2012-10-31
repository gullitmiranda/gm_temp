class CreateRdcmsArticleImages < ActiveRecord::Migration
  def change
    create_table :rdcms_article_images do |t|
      t.integer :article_id
      t.integer :image_id
      t.string :position

      t.timestamps
    end
  end
end
