class AddArticleTypeToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :article_type, :string
  end
end
