class CreateArticles < ActiveRecord::Migration
  def change
    create_table :rdcms_articles do |t|
      t.string :title

      t.string :url_name
      t.string :slug
      t.text :content
      t.text :teaser
      t.string :ancestry
      t.boolean :startpage, :default => false
      t.boolean :active, :default => true
      t.string :subtitle
      t.text :summary
      t.text :context_info
      t.string :canonical_url
      t.boolean :robots_no_index, :default => false
      t.string :breadcrumb
      t.string :template_file
      t.boolean :enable_social_sharing
      t.integer :article_for_index_id
      t.integer :article_for_index_levels, :default => 0
      t.integer :article_for_index_count, :default => 0
      t.boolean :article_for_index_images, :default => false
      t.boolean :cacheable, :default => true
      t.string :image_gallery_tags
      t.string :article_type
      t.string :external_url_redirect
      t.string :index_of_articles_tagged_with
      t.string :sort_order
      t.boolean :reverse_sort
      t.string :author
      t.integer :sorter_limit
      t.string :not_tagged_with
      t.boolean :use_frontend_tags, default: false
      t.string :dynamic_redirection, :default => "false"
      t.boolean :redirection_target_in_new_window, :default => false
      t.boolean :commentable, :default => false
      t.datetime :active_since, :default => (Time.now - 1.week)
      t.string :redirect_link_title

      t.timestamps
    end

    add_index :rdcms_articles, :slug
    add_index :rdcms_articles, :ancestry
  end
end
