class CreateRdcmsWidgets < ActiveRecord::Migration
  def change
    create_table :rdcms_widgets do |t|
      t.string :title
      t.text :content
      t.string :css_name
      t.boolean :active

      t.timestamps
    end
  end
end
