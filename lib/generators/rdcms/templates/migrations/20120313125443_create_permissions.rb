class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.string :action
      t.string :subject_class
      t.string :subject_id
      t.integer :role_id

      t.timestamps
    end
    
    Permission.create(:role_id => Role.find_by_name("admin").id, :action => "manage", :subject_class => ":all" )
    Permission.create(:role_id => Role.find_by_name("guest").id, :action => "read", :subject_class => "Article" ) 
    Permission.create(:role_id => Role.find_by_name("guest").id, :action => "show", :subject_class => "User", :subject_id => "user.id" )
    Permission.create(:role_id => Role.find_by_name("guest").id, :action => "update", :subject_class => "User", :subject_id => "user.id" )
    Permission.create(:role_id => Role.find_by_name("guest").id, :action => "destroy", :subject_class => "User", :subject_id => "user.id" )    
  end
  
  def self.down
    drop_table :permissions
  end
  
end
