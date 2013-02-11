# == Schema Information
#
# Table name: widgets
#
#  id                          :integer          not null, primary key
#  title                       :string(255)
#  content                     :text
#  css_name                    :string(255)
#  active                      :boolean
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  id_name                     :string(255)
#  sorter                      :integer
#  mobile_content              :text
#  teaser                      :string(255)
#  default                     :boolean
#  description                 :text
#  offline_days                :string(255)
#  offline_time_active         :boolean
#  alternative_content         :text
#  offline_date_start          :date
#  offline_date_end            :date
#  offline_time_week_start_end :text
#

require 'test_helper'

class WidgetTest < ActiveSupport::TestCase
# test "the truth" do
#   assert true
# end
end
