class AddIndextagToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :index_of_articles_tagged_with, :string
  end
end
