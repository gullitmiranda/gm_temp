class AddNameToRdcmsWidgets < ActiveRecord::Migration
  def change
    add_column :rdcms_widgets, :id_name, :string

  end
end
