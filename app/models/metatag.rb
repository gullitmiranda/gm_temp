# == Schema Information
#
# Table name: metatags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  value      :string(255)
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Metatag < ActiveRecord::Base
  attr_accessible :name, :value, :post_id
  belongs_to :post
  # belongs_to :article
end
