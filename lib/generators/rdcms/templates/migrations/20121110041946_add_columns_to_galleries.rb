class AddColumnsToGalleries < ActiveRecord::Migration
    change_table :galleries do |t|
      t.boolean :published, :default => false
    end
end
