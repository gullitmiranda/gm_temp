class Page < ActiveRecord::Base
  attr_accessible :content, :name, :published, :in_menu, :slug,
                  # I18n
                  :translations_attributes, :published

  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Escopos
  scope :visible, where("published = ?", true)
  scope :in_menu, where("in_menu = ?", true)

  # Contador de visitas
  is_visitable accept_ip: true

  # Translate
  translates :name, :content
  accepts_nested_attributes_for :translations

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
