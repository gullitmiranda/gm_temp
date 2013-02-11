class AddNottagsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :not_tagged_with, :string
  end
end
