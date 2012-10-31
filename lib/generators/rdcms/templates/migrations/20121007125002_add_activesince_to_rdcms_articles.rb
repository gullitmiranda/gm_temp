class AddActivesinceToRdcmsArticles < ActiveRecord::Migration
  def change
    add_column :rdcms_articles, :active_since, :datetime, :default => (Time.now - 1.week)
  end
end
