class Gallery < ActiveRecord::Base
  attr_accessible :datetime, :name, :description,
      :slug, :locale, :translations_attributes, :tag_list, :position, :published,
      # Associações
      :upload_ids, :upload

  # Relacionando com os uploads
  has_and_belongs_to_many :uploads,
    :join_table => "galleries_uploads",
    :order => "position asc"
  accepts_nested_attributes_for :uploads

  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Escopos
  scope :with_locale, lambda{ with_translations(I18n.locale)}
  scope :active     , lambda{ where(:published => true)     }
  scope :inactive   , lambda{ where(:published => false)    }
  scope :ordained   , lambda{ order("datetime desc")        }

  scope :list_all   , lambda{ with_locale.active.ordained   }
  scope :recents    , lambda{ |limit = 10| active.ordained.limit(limit) }

  # Taggings
  acts_as_taggable

  # Contador de visitas
  is_visitable accept_ip: true

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

  # Refaz a ordenação dos uploads
  def reorder_positions(ids = nil)
    [] if ids.blank?
    counter = 1
    ActiveRecord::Base.establish_connection
    ids.each do |id|
      ActiveRecord::Base.connection.execute("UPDATE galleries_uploads SET position='#{counter}' WHERE gallery_id='#{self.id}' AND upload_id='#{id}';\n")
      counter += 1
    end
  end
end
