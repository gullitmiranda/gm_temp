class AddColumnsImagesToPost < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.string :posts_file_name
      t.string :posts_content_type
      t.integer :posts_file_size
    end
  end
end
