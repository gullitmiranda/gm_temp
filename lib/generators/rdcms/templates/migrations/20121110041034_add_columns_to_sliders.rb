class AddColumnsToSliders < ActiveRecord::Migration
  def change
    change_table :sliders do |t|
      t.integer :position
      t.boolean :published, :default => false
    end
  end
end
