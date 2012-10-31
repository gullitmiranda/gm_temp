class CreateRdcmsPermissions < ActiveRecord::Migration
  def self.up
    create_table :rdcms_permissions do |t|
      t.string :action
      t.string :subject_class
      t.string :subject_id
      t.integer :role_id

      t.timestamps
    end
    
    Rdcms::Permission.create(:role_id => Rdcms::Role.find_by_name("admin").id, :action => "manage", :subject_class => ":all" )
    Rdcms::Permission.create(:role_id => Rdcms::Role.find_by_name("guest").id, :action => "read", :subject_class => "Rdcms::Article" ) 
    Rdcms::Permission.create(:role_id => Rdcms::Role.find_by_name("guest").id, :action => "show", :subject_class => "User", :subject_id => "user.id" )
    Rdcms::Permission.create(:role_id => Rdcms::Role.find_by_name("guest").id, :action => "update", :subject_class => "User", :subject_id => "user.id" )
    Rdcms::Permission.create(:role_id => Rdcms::Role.find_by_name("guest").id, :action => "destroy", :subject_class => "User", :subject_id => "user.id" )    
  end
  
  def self.down
    drop_table :rdcms_permissions
  end
  
end
