# == Schema Information
#
# Table name: settings
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  value      :string(255)
#  ancestry   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class SettingTest < ActiveSupport::TestCase
	# test "the truth" do
	#   assert true
	# end
end
