# == Schema Information
#
# Table name: article_images
#
#  id         :integer(4)      not null, primary key
#  article_id :integer(4)
#  image_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  position   :string(255)
#

require 'test_helper'

class ArticleImageTest < ActiveSupport::TestCase
# test "the truth" do
#   assert true
# end
end
