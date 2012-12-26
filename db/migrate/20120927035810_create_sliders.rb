class CreateSliders < ActiveRecord::Migration
  def up
    create_table :sliders do |t|
      t.string :slug
      t.string :name
      t.text :body

      t.string :background_file_name
      t.string :background_content_type
      t.integer :background_file_size
      t.datetime :background_updated_at

      t.timestamps
    end
    
    add_index :sliders, :name
    add_index :sliders, :slug, :unique => true
    
    Slider.create_translation_table! :name => :string, :body => :text
  end

  def down
    drop_table :sliders
    Slider.drop_translation_table!
  end
end
