# == Schema Information
#
# Table name: imports
#
#  id           :integer          not null, primary key
#  assignment   :text
#  target_model :string(255)
#  successful   :boolean
#  upload_id    :integer
#  separator    :string(255)      default(",")
#  result       :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class ImportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
