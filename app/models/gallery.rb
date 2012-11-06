class Gallery < ActiveRecord::Base
  attr_accessible :datetime, :name, :description,
      :slug, :locale, :translations_attributes, :tag_list,
      # Associações
      :upload_ids, :upload

  # Relacionando com os uploads
  has_and_belongs_to_many :uploads, :join_table => "galleries_uploads"
  accepts_nested_attributes_for :uploads

  # Validações
  # validates :name, :presence => true, :uniqueness => true

  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Escopos
  scope :recents, lambda{ |limit = 10| order("datetime desc").limit(limit)}

# Translate
  translates :name, :description
  accepts_nested_attributes_for :translations
  
  class Translation
    attr_accessible :locale, :name, :description
  end
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
    set_translations new_translations
  end

  # Taggings
  acts_as_taggable
end
