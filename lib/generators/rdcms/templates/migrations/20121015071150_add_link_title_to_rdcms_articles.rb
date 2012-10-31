class AddLinkTitleToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :redirect_link_title, :string
  end
end
