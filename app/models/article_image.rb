# == Schema Information
#
# Table name: article_images
#
#  id         :integer          not null, primary key
#  article_id :integer
#  image_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :string(255)
#

class ArticleImage < ActiveRecord::Base
	belongs_to :article
	belongs_to :image, :class_name => Upload, :foreign_key => "image_id"
end
