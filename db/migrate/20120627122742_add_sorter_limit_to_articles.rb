class AddSorterLimitToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :sorter_limit, :integer
  end
end
