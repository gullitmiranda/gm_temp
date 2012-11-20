class Slider < ActiveRecord::Base
  attr_accessible :body, :name, :position, :published,
    # Slug, I18n e tags
    :slug, :locale, :translations_attributes, :tag_list,
    # Paperclip
    :background, :background_content_type, :background_file_name, :background_file_size, :background_updated_at
  # Taggings
  acts_as_taggable
  
  has_attached_file :background, :styles => {
    :thumb        => "260x180#",
    :slider       => "1920x1200#"
  }
  
  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
  # Translate
  translates :name, :body
  accepts_nested_attributes_for :translations

  # Escopos
  scope :visible, where("published = ?", true)
  scope :recents, lambda{ |limit = 10| visible.order("datetime desc").limit(limit)}
  scope :ordained, lambda{ |limit = 10| visible.order("position asc").limit(limit)}

  
  class Translation
    attr_accessible :locale, :name, :body
  end
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
    set_translations new_translations
  end
end
