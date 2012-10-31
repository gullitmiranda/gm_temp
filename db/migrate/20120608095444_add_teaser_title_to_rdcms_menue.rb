class AddTeaserTitleToRdcmsMenue < ActiveRecord::Migration
  def change
    add_column :rdcms_menues, :description_title, :string
  end
end
