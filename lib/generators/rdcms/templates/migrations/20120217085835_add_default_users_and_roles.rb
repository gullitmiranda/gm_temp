class AddDefaultUsersAndRoles < ActiveRecord::Migration
  def up
    admin = Role.find_or_create_by_name("admin")
    guest = Role.find_or_create_by_name("guest")
    user = User.create!(:email => "admin@rd.dev", :password => "password", :password_confirmation => "password", :firstname => "Requestdev", :lastname => "Administrador")
    user.roles << admin
  end

  def down
    User.scoped.destroy_all
    Role.scoped.destroy_all
  end
end
