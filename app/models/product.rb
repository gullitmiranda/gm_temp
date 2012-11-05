class Product < ActiveRecord::Base
  attr_accessible :name, :description, :price, :length, :width, :height, :weight,
      :locale, :translations_attributes, :tag_list,
      # Associações
      :upload_ids, :upload
  
  # Relacionando com os uploads
  has_and_belongs_to_many :uploads, :join_table => "products_uploads"
  accepts_nested_attributes_for :uploads

  # attr_accessible :images
  # has_attached_file :images
  # Validações
#  validates :name, :presence => true, :uniqueness => true
  
  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
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
