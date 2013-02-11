# == Schema Information
#
# Table name: article_images
#
#  id         :integer          not null, primary key
#  article_id :integer
#  image_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :string(255)
#

require 'test_helper'

class ArticleImageTest < ActiveSupport::TestCase
# test "the truth" do
#   assert true
# end
end
