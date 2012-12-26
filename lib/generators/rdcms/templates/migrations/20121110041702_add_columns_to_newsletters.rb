class AddColumnsToNewsletters < ActiveRecord::Migration
  def change
    change_table :newsletters do |t|
      t.boolean :downloaded, :default => false
    end
  end
end
