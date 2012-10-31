class AddUrlnameToArticle < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :url_name, :string
    add_column :rdcms_articles, :slug, :string
    add_index :rdcms_articles, :slug
  end
end
