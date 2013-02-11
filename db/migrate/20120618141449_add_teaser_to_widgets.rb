class AddTeaserToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :teaser, :string
  end
end
