class AddArticleindexToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :article_for_index_id, :integer
    add_column :rdcms_articles, :article_for_index_levels, :integer, :default => 0
    add_column :rdcms_articles, :article_for_index_count, :integer, :default => 0
  end
end
