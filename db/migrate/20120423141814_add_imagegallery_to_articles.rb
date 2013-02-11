class AddImagegalleryToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :image_gallery_tags, :string
  end
end
