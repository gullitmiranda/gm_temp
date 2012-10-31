class AddCommentableToArticle < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :commentable, :boolean, :default => false
  end
end
