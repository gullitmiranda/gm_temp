class Publication < ActiveRecord::Base
  attr_accessible :name, :body, :datetime, :position, :object_type, :published, :ids_order,
    # Slug, I18n, tags e anscestry
    :slug, :locale, :translations_attributes, :tag_list, :ancestry, :parent_id,
    # Paperclip
    :publication, :publication_content_type, :publication_file_name, :publication_file_size
  # Taggings
  acts_as_taggable

  # Ancestrais
  has_ancestry

  # Get Attached Styles for paperclip
  def self.get_attached_styles
    @attached_styles = {
      :thumb => Setting.for_key("rdcms.publication.thumb"),
      :page => Setting.for_key("rdcms.publication.page")
    }
  end

  has_attached_file :publication,
                    :styles => self.get_attached_styles,
                    :processors => [:thumbnail, :compression],
                    :convert_options => { :all => '-auto-orient -quality 70 -interlace Plane' }

  # URL amigáveis através do :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Escopos
  scope :publication_root, where("ancestry is ?", nil)
  scope :visible, where("published = ?", true)
  scope :recents, lambda{ |limit = 10| visible.order("datetime desc").limit(limit)}
  scope :ordained, order("position asc").order("datetime desc")

  # View scopes
  scope :catalogue, where("object_type=?", 0)
  scope :campaign,  where("object_type=?", 1)

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

  # Internal: Makes sure to only post-process files which are either pdf
  # or image files. Word documents would break file upload.
  #
  # No params
  #
  # Returns true for image or pdf files and false for everything else
  def image_file?
    !(self.publication_content_type =~ /^image.*/).nil? || !(self.publication_content_type =~ /pdf/).nil?
  end

  #Jquery File Uploads
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper
  # include I18n::Backend::Fallbacks
  # include I18n::Backend::Simple

  def to_jq_upload
    {
      "id"            => read_attribute(:id),
      "name"          => read_attribute(:name) || read_attribute(:publication_file_name),
      "content_type"  => read_attribute(:publication_content_type),
      "size"          => read_attribute(:publication_file_size),
      "updated_at"    => read_attribute(:updated_at),
      "created_at"    => read_attribute(:created_at),
      "images" =>  {
        "original"    => publication.url,
        "page"        => publication.url(:page  ),
        "thumb"       => publication.url(:thumb  ),
      },
      "url"           => publication.url(:original),
      "page"          => publication.url(:page),
      "thumb"         => publication.url(:thumb),
      "edit_url"      => admin_edit_page_publication_path(self),
      "delete_url"    => admin_publication_path(self),
      "delete_type"   => "DELETE",
      "i18n" => {
        "size"        => number_to_human_size(read_attribute(:publication_file_size)),
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
      ActiveRecord::Base.connection.execute("UPDATE publications SET position=#{counter} WHERE id='#{id}';\n")
      counter += 1
    end
    return true
  end
end
