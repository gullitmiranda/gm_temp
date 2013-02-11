class AddPolyToRoleUsers < ActiveRecord::Migration
  def change
    add_column :roles_users, :operator_type, :string, :default => "User"
    rename_column :roles_users, :user_id, :operator_id
  end
end
