class AddAncestryToArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :ancestry, :string

  end
end
