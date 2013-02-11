class AddLinkTitleToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :redirect_link_title, :string
  end
end
