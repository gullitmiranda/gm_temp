class RoleUser < ActiveRecord::Base
	belongs_to :user, :class_name => User, :foreign_key => :user_id
	belongs_to :role, :class_name => Role
end
