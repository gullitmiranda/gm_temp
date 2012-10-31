class AddSorterToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :sort_order, :string
  end
end
