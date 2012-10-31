# == Schema Information
#
# Table name: rdcms_helps
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :text
#  url         :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

module Rdcms
  class Help < ActiveRecord::Base
    attr_accessible :title, :description, :url
  end
end
