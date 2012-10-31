class AddPositionToRdcmsArticleImages < ActiveRecord::Migration
  def change
    add_column :rdcms_article_images, :position, :string
  end
end
