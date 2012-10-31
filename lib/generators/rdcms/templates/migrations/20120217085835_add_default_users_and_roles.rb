class AddDefaultUsersAndRoles < ActiveRecord::Migration
  def up
    admin = Rdcms::Role.find_or_create_by_name("admin")
    guest = Rdcms::Role.find_or_create_by_name("guest")
    user = User.create!(:email => "admin@rdcms.de", :password => "administrator", :password_confirmation => "administrator", :firstname => "Admin", :lastname => "Rdcms")
    user.roles << admin
  end

  def down
    User.scoped.destroy_all
    Rdcms::Role.scoped.destroy_all
  end
end
