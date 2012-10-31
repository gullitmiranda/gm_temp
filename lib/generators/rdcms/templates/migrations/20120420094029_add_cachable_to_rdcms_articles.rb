class AddCachableToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :cacheable, :boolean, :default => true
  end
end
