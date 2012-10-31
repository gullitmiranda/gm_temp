class AddDescriptionToRdcmsMenues < ActiveRecord::Migration
  def change
    add_column :rdcms_menues, :description, :text
    add_column :rdcms_menues, :call_to_action_name, :string
  end
end
