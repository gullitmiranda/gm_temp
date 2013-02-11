class AddExternalurlToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :external_url_redirect, :string
  end
end
