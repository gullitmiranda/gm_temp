class AddPositionToArticleImages < ActiveRecord::Migration
  def change
    add_column :article_images, :position, :string
  end
end
