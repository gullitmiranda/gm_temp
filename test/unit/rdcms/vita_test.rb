# == Schema Information
#
# Table name: vita
#
#  id            :integer(4)      not null, primary key
#  loggable_id   :integer(4)
#  loggable_type :string(255)
#  user_id       :integer(4)
#  title         :string(255)
#  description   :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'test_helper'

class VitaTest < ActiveSupport::TestCase
# test "the truth" do
#   assert true
# end
end
