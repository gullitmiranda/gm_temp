class AddAuthorToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :author, :string
  end
end
