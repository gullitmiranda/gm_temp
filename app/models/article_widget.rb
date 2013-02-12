# == Schema Information
#
# Table name: article_widgets
#
#  id         :integer          not null, primary key
#  article_id :integer
#  widget_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleWidget < ActiveRecord::Base
	belongs_to :article
	belongs_to :widget
end
