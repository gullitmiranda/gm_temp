class AddIndextagToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :index_of_articles_tagged_with, :string
  end
end
