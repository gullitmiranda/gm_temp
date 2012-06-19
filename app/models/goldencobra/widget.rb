# == Schema Information
#
# Table name: goldencobra_widgets
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  content        :text
#  css_name       :string(255)
#  active         :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  id_name        :string(255)
#  sorter         :integer
#  mobile_content :text
#  teaser         :string(255)
#

module Goldencobra
  class Widget < ActiveRecord::Base
    acts_as_taggable_on :tags
    has_many :article_widgets
    has_many :articles, :through => :article_widgets
    scope :active, where(:active => true).order(:sorter)
    after_save 'Goldencobra::Article.recreate_cache'
    has_paper_trail
    
    before_save :set_default_tag
    
    def set_default_tag
      self.tag_list = "sidebar" if self.tag_list.blank?
    end
    
  end
end
