# == Schema Information
#
# Table name: permissions
#
#  id            :integer          not null, primary key
#  action        :string(255)
#  subject_class :string(255)
#  subject_id    :string(255)
#  role_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  sorter_id     :integer          default(0)
#

require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
	# test "the truth" do
	#   assert true
	# end
end
