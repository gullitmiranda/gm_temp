class AddColumnsToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      # t.text :summary
      t.string :ancestry
      t.boolean :published, :default => false
    end

    add_index :posts, :ancestry

    # change_table :post_translations do |t|
    #   t.text :summary
    # end
  end
end
