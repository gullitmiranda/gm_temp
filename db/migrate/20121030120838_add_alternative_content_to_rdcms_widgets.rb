class AddAlternativeContentToRdcmsWidgets < ActiveRecord::Migration
  def change
    add_column :rdcms_widgets, :alternative_content, :text
  end
end
