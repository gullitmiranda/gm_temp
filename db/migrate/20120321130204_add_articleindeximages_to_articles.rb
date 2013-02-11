class AddArticleindeximagesToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :article_for_index_images, :boolean, :default => false
  end
end
