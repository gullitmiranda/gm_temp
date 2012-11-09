class Slider < ActiveRecord::Base
  attr_accessible :body, :name, :background, :background_content_type, :background_file_name, :background_file_size, :background_updated_at, :locale, :translations_attributes, :tag_list
  # Taggings
  acts_as_taggable
  
  has_attached_file :background, :styles => {
    :thumb        => "260x180#",
    :slider       => "1150x400#"
  }
  
  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
  # Translate
  translates :name, :body
  accepts_nested_attributes_for :translations

  
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
