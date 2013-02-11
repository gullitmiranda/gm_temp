class AddReverseSortToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :reverse_sort, :boolean
  end
end
