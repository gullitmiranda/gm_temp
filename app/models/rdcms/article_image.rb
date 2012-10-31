# == Schema Information
#
# Table name: rdcms_article_images
#
#  id         :integer(4)      not null, primary key
#  article_id :integer(4)
#  image_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  position   :string(255)
#

module Rdcms
  class ArticleImage < ActiveRecord::Base
    belongs_to :article
    belongs_to :image, :class_name => Rdcms::Upload, :foreign_key => "image_id"

  end
end
