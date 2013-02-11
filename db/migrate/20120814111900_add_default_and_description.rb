class AddDefaultAndDescription < ActiveRecord::Migration
  def change
    add_column :widgets, :default, :string
    add_column :widgets, :description, :text
  end
end
