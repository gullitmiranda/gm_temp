# == Schema Information
#
# Table name: rdcms_permissions
#
#  id            :integer(4)      not null, primary key
#  action        :string(255)
#  subject_class :string(255)
#  subject_id    :string(255)
#  role_id       :integer(4)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'test_helper'

module Rdcms
  class PermissionTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
