class AddAlternativeContentToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :alternative_content, :text
  end
end
