# == Schema Information
#
# Table name: article_widgets
#
#  id         :integer(4)      not null, primary key
#  article_id :integer(4)
#  widget_id  :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ArticleWidget < ActiveRecord::Base
	belongs_to :article
	belongs_to :widget
end
