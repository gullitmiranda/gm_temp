class AddAncestryToMenues < ActiveRecord::Migration
  def change
    add_column :rdcms_menues, :ancestry, :string
    add_index :rdcms_menues, :ancestry
  end
end
