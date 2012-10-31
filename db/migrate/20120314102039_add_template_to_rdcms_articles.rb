class AddTemplateToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :template_file, :string

  end
end
