class AddImagegalleryToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :image_gallery_tags, :string
  end
end
