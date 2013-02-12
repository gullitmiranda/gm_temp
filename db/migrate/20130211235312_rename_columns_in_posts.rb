class RenameColumnsInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :article_type, :post_type
  end
end
