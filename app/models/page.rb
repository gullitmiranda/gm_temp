class Page < ActiveRecord::Base
  attr_accessible :content, :name, :published, :slug,
  								# I18n
  								:translations_attributes, :published

  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Translate
  translates :name, :content
  accepts_nested_attributes_for :translations
  
  # Escopos
  scope :visible, where("published = ?", true)

  class Translation
    attr_accessible :locale, :name, :content
  end
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
    set_translations new_translations
  end
end
