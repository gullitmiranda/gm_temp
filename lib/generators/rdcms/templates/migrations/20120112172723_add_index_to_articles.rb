class AddIndexToArticles < ActiveRecord::Migration
  def up
    add_index :rdcms_articles, :ancestry
  end
  
  def down
    remove_index :rdcms_articles, :ancestry
  end
end
