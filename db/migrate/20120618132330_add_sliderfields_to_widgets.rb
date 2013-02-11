class AddSliderfieldsToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :mobile_content, :text
  end
end
