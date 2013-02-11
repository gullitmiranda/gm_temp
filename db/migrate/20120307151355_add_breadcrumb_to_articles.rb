class AddBreadcrumbToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :breadcrumb, :string
  end
end
