class AddDynamicredirectToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :dynamic_redirection, :string, :default => "false"
    add_column :articles, :redirection_target_in_new_window, :boolean, :default => false
  end
end
