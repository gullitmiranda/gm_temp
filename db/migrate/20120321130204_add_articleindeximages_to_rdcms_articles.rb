class AddArticleindeximagesToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :article_for_index_images, :boolean, :default => false

  end
end
