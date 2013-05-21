class Partner < ActiveRecord::Base
  attr_accessible :name, :description, :position, :published, :url,
    # Slug, I18n, tags e anscestry
    :slug, :locale, :translations_attributes,
    # Paperclip
    :partner, :partner_file_name, :partner_content_type, :partner_file_size

  has_attached_file :partner,
                    :styles => { :thumb => "260x180#" },
                    :convert_options => { :all => '-auto-orient -quality 70 -interlace Plane' }

  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Escopos
  scope :visible, where("published = ?", true)
  scope :ordained, order("position asc")

  # Contador de visitas
  is_visitable accept_ip: true

  # Translate
  translates :description
  accepts_nested_attributes_for :translations

  class Translation
    attr_accessible :locale, :description
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
      "name"          => read_attribute(:name) || read_attribute(:partner_file_name),
      "content_type"  => read_attribute(:partner_content_type),
      "size"          => read_attribute(:partner_file_size),
      "updated_at"    => read_attribute(:updated_at),
      "created_at"    => read_attribute(:created_at),
      "images" =>  {
        "original"    => partner.url,
        "thumb"       => partner.url(:thumb  ),
      },
      "url"           => partner.url(:original),
      "thumb"         => partner.url(:thumb),
      "edit_url"      => edit_admin_partner_path(self),
      "delete_url"    => admin_partner_path(self),
      "delete_type"   => "DELETE",
      "i18n" => {
        "size"        => number_to_human_size(read_attribute(:partner_file_size)),
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
      ActiveRecord::Base.connection.execute("UPDATE partners SET position=#{counter} WHERE id='#{id}';\n")
      counter += 1
    end
    return true
  end
end
