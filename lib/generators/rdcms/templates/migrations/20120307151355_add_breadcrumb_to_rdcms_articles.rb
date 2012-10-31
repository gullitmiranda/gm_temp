class AddBreadcrumbToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :breadcrumb, :string

  end
end
