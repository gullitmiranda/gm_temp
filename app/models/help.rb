# == Schema Information
#
# Table name: helps
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Help < ActiveRecord::Base
  attr_accessible :title, :description, :url
end
