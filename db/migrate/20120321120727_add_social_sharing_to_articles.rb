class AddSocialSharingToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :enable_social_sharing, :boolean
  end
end
