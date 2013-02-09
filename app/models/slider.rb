class Slider < ActiveRecord::Base
  attr_accessible :body, :name, :position, :published,
    # Slug, I18n e tags
    :slug, :locale, :translations_attributes, :tag_list,
    # Paperclip
    :background, :background_content_type, :background_file_name, :background_file_size
  # Taggings
  acts_as_taggable

  has_attached_file :background,
                    :styles => {
                      :thumb        => "260x180#",
                      :slider       => "1920x1200#"
                    },
                    :convert_options => { :all => '-auto-orient -quality 70 -interlace Plane' }

  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Escopos
  scope :visible, where("published = ?", true)
  scope :recents, lambda{ |limit = 10| visible.order("created_at desc").limit(limit)}
  scope :ordained, order("position asc, updated_at desc")

  # Contador de visitas
  is_visitable accept_ip: true

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

  #Jquery File Uploads
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper
  # include I18n::Backend::Fallbacks
  # include I18n::Backend::Simple

  def to_jq_upload
    {
      "id"            => read_attribute(:id),
      "name"          => read_attribute(:name) || read_attribute(:background_file_name),
      "content_type"  => read_attribute(:background_content_type),
      "size"          => read_attribute(:background_file_size),
      "updated_at"    => read_attribute(:updated_at),
      "created_at"    => read_attribute(:created_at),
      "images" =>  {
        "original"    => background.url,
        "page"        => background.url(:page  ),
        "thumb"       => background.url(:thumb  ),
      },
      "url"           => background.url(:original),
      "page"          => background.url(:page),
      "thumb"         => background.url(:thumb),
      "edit_url"      => edit_admin_slider_path(self),
      "delete_url"    => admin_slider_path(self),
      "delete_type"   => "DELETE",
      "i18n" => {
        "size"        => number_to_human_size(read_attribute(:background_file_size)),
        "updated_at"  => I18n.l(read_attribute(:updated_at), format: :long),
        "created_at"  => I18n.l(read_attribute(:created_at), format: :long),
      }
    }
  end

  # Refaz a ordenação dos uploads
  def self.reorder_positions(ids = nil)
    [] if ids.blank?
    counter = 1
    ActiveRecord::Base.establish_connection
    ids.each do |id|
      ActiveRecord::Base.connection.execute("UPDATE sliders SET position=#{counter} WHERE id='#{id}';\n")
      counter += 1
    end
    return true
  end
end
