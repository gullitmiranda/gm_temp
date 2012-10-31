class AddDefaultAndDescriptionToRdcms < ActiveRecord::Migration
  def change
    add_column :rdcms_widgets, :default, :string
    add_column :rdcms_widgets, :description, :text
  end
end