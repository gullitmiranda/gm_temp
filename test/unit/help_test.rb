# == Schema Information
#
# Table name: helps
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class HelpTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
