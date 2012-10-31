class AddNottagsToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :not_tagged_with, :string
  end
end
