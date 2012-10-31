class AddAttachableToRdcmsUploads < ActiveRecord::Migration
  def change
    add_column :rdcms_uploads, :attachable_id, :integer
    add_column :rdcms_uploads, :attachable_type, :string
  end
end
