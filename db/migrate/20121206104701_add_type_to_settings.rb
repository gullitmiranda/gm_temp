class AddTypeToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :data_type, :string, :default => "string"
  end
end
