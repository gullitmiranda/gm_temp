class Product < ActiveRecord::Base
  attr_accessible :name, :description, :price, :length, :width, :height, :weight,
      :slug, :locale, :translations_attributes, :tag_list,
      # Associações
      :upload_ids, :upload
  
  # Relacionando com os uploads
  has_and_belongs_to_many :uploads,
    :join_table => "products_uploads",
    :order => "position asc"#,
    # :insert_sql =>  proc { |record|
    #   # created_at = record.created_at == "0000-00-00 00:00:00" ? Time.now : record.created_at
    #   %{INSERT INTO `products_uploads` (`product_id`, `upload_id`, `position`) VALUES ( "#{self.id}", "#{record.id}", "#{Time.now.to_i}" )}
    #   # %{INSERT INTO `products_uploads` (`product_id`, `upload_id`, `position`, `created_at`, `updated_at`) VALUES ( "#{self.id}","#{record.id}", "#{Time.now.to_i}", "#{created_at}", "#{Time.now}" )}
    # }
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


  # Escopos
  # scope :recents, lambda{ |counter| order("updated_at DESC").limit(counter)}
  # scope :visible, where("hidden != ?", true)
  # scope :published, lambda { where("published_at <= ?", Time.zone.now) }
  scope :recents, lambda{ |limit = 10| order("updated_at desc").limit(limit)}

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

  # Refaz a ordenação dos uploads
  def reorder_positions(ids = nil)
    [] if ids.blank?
    counter = 1
    ActiveRecord::Base.establish_connection
    ids.each do |id|
      ActiveRecord::Base.connection.execute("UPDATE products_uploads SET position=#{counter}, updated_at='#{Time.now}' WHERE product_id='#{self.id}' AND upload_id='#{id}';\n")
      counter += 1
    end
  end
end
