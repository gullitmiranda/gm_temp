class CreateArticleWidgets < ActiveRecord::Migration
  def change
    create_table :article_widgets do |t|
      t.integer :article_id
      t.integer :widget_id

      t.timestamps
    end
  end
end
