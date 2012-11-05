# == Schema Information
#
# Table name: widgets
#
#  id                  :integer(4)      not null, primary key
#  title               :string(255)
#  content             :text
#  css_name            :string(255)
#  active              :boolean(1)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  id_name             :string(255)
#  sorter              :integer(4)
#  mobile_content      :text
#  teaser              :string(255)
#  default             :boolean(1)
#  description         :text
#  offline_days        :string(255)
#  offline_time_start  :datetime
#  offline_time_end    :datetime
#  offline_time_active :boolean(1)
#  alternative_content :text
#

require 'test_helper'

class WidgetTest < ActiveSupport::TestCase
# test "the truth" do
#   assert true
# end
end
