# == Schema Information
#
# Table name: vita
#
#  id            :integer          not null, primary key
#  loggable_id   :integer
#  loggable_type :string(255)
#  user_id       :integer
#  title         :string(255)
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Vita < ActiveRecord::Base
	belongs_to :loggable, :polymorphic => true
	attr_accessible :description, :title, :user_id
	acts_as_taggable_on :tags
end
