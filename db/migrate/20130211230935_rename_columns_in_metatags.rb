class RenameColumnsInMetatags < ActiveRecord::Migration
  def change
    rename_column :metatags, :article_id, :post_id
    rename_column :comments, :article_id, :post_id
  end
end
