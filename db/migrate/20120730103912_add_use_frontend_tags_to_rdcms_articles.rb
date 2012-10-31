class AddUseFrontendTagsToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :use_frontend_tags, :boolean, default: false
  end
end
