# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  lat        :string(255)
#  lng        :string(255)
#  street     :string(255)
#  city       :string(255)
#  zip        :string(255)
#  region     :string(255)
#  country    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
