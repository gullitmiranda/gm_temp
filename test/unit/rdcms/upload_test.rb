# == Schema Information
#
# Table name: uploads
#
#  id                 :integer(4)      not null, primary key
#  source             :string(255)
#  rights             :string(255)
#  description        :text
#  upload_file_name    :string(255)
#  upload_content_type :string(255)
#  upload_file_size    :integer(4)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  attachable_id      :integer(4)
#  attachable_type    :string(255)
#  alt_text           :string(255)
#

require 'test_helper'

class UploadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
