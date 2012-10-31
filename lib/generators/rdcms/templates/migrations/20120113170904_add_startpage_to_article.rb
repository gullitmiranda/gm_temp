class AddStartpageToArticle < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :startpage, :boolean, :default => false
  end
end
