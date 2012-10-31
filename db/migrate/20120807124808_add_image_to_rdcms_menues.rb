class AddImageToRdcmsMenues < ActiveRecord::Migration
  def change
    add_column :rdcms_menues, :image_id, :integer
  end
end
