class AddSorterToRdcmsWidgets < ActiveRecord::Migration
  def change
    add_column :rdcms_widgets, :sorter, :integer

  end
end
