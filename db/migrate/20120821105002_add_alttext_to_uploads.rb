class AddAlttextToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :alt_text, :string
  end
end
