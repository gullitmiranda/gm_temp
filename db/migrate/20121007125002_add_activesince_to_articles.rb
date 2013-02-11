class AddActivesinceToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :active_since, :datetime, :default => (Time.now - 1.week)
  end
end
