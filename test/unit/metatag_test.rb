# == Schema Information
#
# Table name: metatags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  value      :string(255)
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MetatagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
