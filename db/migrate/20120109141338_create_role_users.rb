class CreateRoleUsers < ActiveRecord::Migration
  def change
    create_table :roles_users, :id => false do |t|
      t.integer :operator_id
      t.integer :role_id
      t.string :operator_type, :default => "User"
    end
  end
end
