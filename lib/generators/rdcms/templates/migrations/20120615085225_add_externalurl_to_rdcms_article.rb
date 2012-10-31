class AddExternalurlToRdcmsArticle < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :external_url_redirect, :string
  end
end
