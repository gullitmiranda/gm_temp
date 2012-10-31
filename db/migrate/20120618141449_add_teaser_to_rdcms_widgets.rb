class AddTeaserToRdcmsWidgets < ActiveRecord::Migration
  def change
    add_column :rdcms_widgets, :teaser, :string
  end
end
