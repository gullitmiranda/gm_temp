class AddBodyToArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :content, :text
    add_column :rdcms_articles, :teaser, :text
  end
end
