# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  value      :string(255)
#  ancestry   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  data_type  :string(255)      default("string")
#

require 'test_helper'

class SettingTest < ActiveSupport::TestCase
	# test "the truth" do
	#   assert true
	# end
end
