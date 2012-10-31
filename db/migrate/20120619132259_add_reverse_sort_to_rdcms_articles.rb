class AddReverseSortToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :reverse_sort, :boolean
  end
end
