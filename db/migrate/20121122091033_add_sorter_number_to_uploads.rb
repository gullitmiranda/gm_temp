class AddSorterNumberToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :sorter_number, :integer
  end
end
