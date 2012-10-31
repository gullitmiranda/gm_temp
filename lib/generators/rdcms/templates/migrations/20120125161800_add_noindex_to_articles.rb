class AddNoindexToArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :robots_no_index, :boolean, :default => false
  end
end
