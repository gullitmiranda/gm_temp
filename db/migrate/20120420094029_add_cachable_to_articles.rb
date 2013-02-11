class AddCachableToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :cacheable, :boolean, :default => true
  end
end
