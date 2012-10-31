class AddAlttextToRdcmsUploads < ActiveRecord::Migration
  def change
    add_column :rdcms_uploads, :alt_text, :string
  end
end
