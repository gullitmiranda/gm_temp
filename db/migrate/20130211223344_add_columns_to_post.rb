class AddColumnsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :cacheable, :boolean, :default => true
    add_column :posts, :article_type, :string
    add_column :posts, :external_url_redirect, :string
    add_column :posts, :redirect_link_title, :string
    add_column :posts, :sort_order, :string
    add_column :posts, :reverse_sort, :boolean
    add_column :posts, :author, :string
    add_column :posts, :dynamic_redirection, :string, :default => "false"
    add_column :posts, :redirection_target_in_new_window, :boolean, :default => false
    add_column :posts, :commentable, :boolean, :default => false
    add_column :posts, :active_since, :datetime, :default => (Time.now - 1.week)
  end
end
