# == Schema Information
#
# Table name: roles_users
#
#  operator_id   :integer
#  role_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  operator_type :string(255)      default("User")
#

class RoleUser < ActiveRecord::Base
  self.table_name = 'roles_users'
  belongs_to :operator, :polymorphic => true
  belongs_to :role
end
