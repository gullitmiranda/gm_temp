class AddCommentableToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :commentable, :boolean, :default => false
  end
end
