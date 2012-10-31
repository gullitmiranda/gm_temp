# == Schema Information
#
# Table name: rdcms_article_widgets
#
#  id         :integer(4)      not null, primary key
#  article_id :integer(4)
#  widget_id  :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

module Rdcms
  class ArticleWidgetTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
