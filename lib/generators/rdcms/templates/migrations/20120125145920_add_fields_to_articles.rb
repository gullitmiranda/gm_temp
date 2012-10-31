class AddFieldsToArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :active, :boolean, :default => true
    add_column :rdcms_articles, :subtitle, :string
    add_column :rdcms_articles, :summary, :text
    add_column :rdcms_articles, :context_info, :text
    add_column :rdcms_articles, :canonical_url, :string
  end
end
