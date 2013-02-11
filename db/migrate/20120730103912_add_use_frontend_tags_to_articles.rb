class AddUseFrontendTagsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :use_frontend_tags, :boolean, default: false
  end
end
