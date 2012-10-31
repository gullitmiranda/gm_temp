# == Schema Information
#
# Table name: rdcms_metatags
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  value      :string(255)
#  article_id :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

module Rdcms
  class Metatag < ActiveRecord::Base
    attr_accessible :name, :value, :article_id
    belongs_to :article
    
  end
end
