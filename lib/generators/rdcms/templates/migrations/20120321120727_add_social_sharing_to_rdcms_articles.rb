class AddSocialSharingToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :enable_social_sharing, :boolean

  end
end
