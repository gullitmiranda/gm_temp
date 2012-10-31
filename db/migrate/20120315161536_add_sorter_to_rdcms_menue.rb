class AddSorterToRdcmsMenue < ActiveRecord::Migration
  def change
    add_column :rdcms_menues, :sorter, :integer, :default => 0

  end
end
