class AddSorterToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :sort_order, :string
  end
end
