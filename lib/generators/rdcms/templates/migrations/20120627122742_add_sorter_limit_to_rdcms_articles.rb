class AddSorterLimitToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :sorter_limit, :integer
  end
end
