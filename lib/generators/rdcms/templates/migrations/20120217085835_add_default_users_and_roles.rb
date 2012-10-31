class AddDefaultUsersAndRoles < ActiveRecord::Migration
  def up
    admin = Rdcms::Role.find_or_create_by_name("admin")
    guest = Rdcms::Role.find_or_create_by_name("guest")
    user = User.create!(:email => "admin@rd.dev", :password => "admin", :password_confirmation => "admin", :firstname => "Requestdev", :lastname => "Administrador")
    user.roles << admin
  end

  def down
    User.scoped.destroy_all
    Rdcms::Role.scoped.destroy_all
  end
end
