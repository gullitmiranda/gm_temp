class AddTemplateToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :template_file, :string

  end
end
