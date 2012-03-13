# == Schema Information
#
# Table name: goldencobra_widgets
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  content    :text
#  css_name   :string(255)
#  active     :boolean(1)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

module Goldencobra
  class Widget < ActiveRecord::Base
    has_many :article_widgets
    has_many :articles, :through => :article_widgets
  end
end