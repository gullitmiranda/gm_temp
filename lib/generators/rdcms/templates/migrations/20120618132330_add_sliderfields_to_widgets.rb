class AddSliderfieldsToWidgets < ActiveRecord::Migration
  def change
    add_column :rdcms_widgets, :mobile_content, :text
  end
end
