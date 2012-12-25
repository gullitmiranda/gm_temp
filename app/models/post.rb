class Post < ActiveRecord::Base
  attr_accessible :datetime, :name, :summary, :body, :slug, :translations_attributes, :tag_list, :published

  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Translate
  translates :name, :body, :summary
  accepts_nested_attributes_for :translations
  
  # Escopos
  scope :visible, where("published = ?", true)
  scope :recents, lambda{ |limit = 10| visible.order("datetime desc").limit(limit)}


  class Translation
    attr_accessible :locale, :name, :body, :summary
  end
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
    set_translations new_translations
  end

  # Taggings
  acts_as_taggable

  # def self.tagged_with(name)
  #   Tag.find_by_name!(name).posts
  # end
  # 
  # def self.tag_counts
  #   Tag.select("tags.*, count(taggings.tag_id) as count").
  #     joins(:taggings).group("taggings.tag_id")
  # end
  # 
  # def tag_list
  #   tags.map(&:name).join(", ")
  # end
  # 
  # def tag_list=(names)
  #   self.tags = names.split(",").map do |n|
  #     Tag.where(name: n.strip).first_or_create!
  #   end
  # end
end
