class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :title
      t.text :content
      t.string :css_name
      t.boolean :active
      t.string :id_name
      t.integer :sorter

      t.text :mobile_content
      t.string :teaser
      t.text :description
      t.boolean :default
      t.string :offline_days
      t.datetime :offline_time_start
      t.datetime :offline_time_end
      t.boolean :offline_time_active
      t.text :alternative_content

      t.timestamps
    end
  end
end
