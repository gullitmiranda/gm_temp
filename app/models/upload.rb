# == Schema Information
#
# Table name: uploads
#
#  id                 :integer          not null, primary key
#  source             :string(255)
#  rights             :string(255)
#  description        :text
#  upload_file_name    :string(255)
#  upload_content_type :string(255)
#  upload_file_size    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  attachable_id      :integer
#  attachable_type    :string(255)
#  alt_text           :string(255)
#  sorter_number      :integer
#

class Upload < ActiveRecord::Base
  attr_accessible :upload, :upload_content_type, :upload_file_name, :upload_file_size,
                  :source, :rights, :tag_list, :description, :alt_text, :item_type
                  # Associações
                  :products_id

  if ActiveRecord::Base.connection.table_exists?("uploads") &&
    ActiveRecord::Base.connection.table_exists?("settings")

    convert_options = Setting.for_key('rdcms.upload.convert_options')
    convert_options = "-auto-orient -strip -normalize -quality 70 -interlace Plane" if convert_options.empty?

    has_attached_file :upload,
                      :styles => {
                        :large  => ["900x900>",:jpg],
                        :big    => ["600x600>",:jpg],
                        :medium => ["570x324#",:jpg],
                        :thumb  => ["260x180#",:jpg],
                        :mini   => ["50x50#"  ,:jpg],

                        # Logo
                        :logo       => ["600x175#"],
                      },
                      :convert_options => { :all => convert_options }

    before_post_process :image_file?
  end

  has_many :article_images, :class_name => ArticleImage
  has_many :articles, :through => :article_images
  has_many :imports, :class_name => Import
  belongs_to :attachable, polymorphic: true
  # has_and_belongs_to_many :products, :join_table => "products_uploads" if Product.exists?
  has_and_belongs_to_many :galleries, :join_table => "galleries_uploads"
  has_and_belongs_to_many :settings, :join_table => "settings_uploads"

  # Taggings
  acts_as_taggable

  # Contador de visitas
  is_visitable accept_ip: true

  REGEXP = case ActiveRecord::Base.connection.adapter_name.downcase.to_sym
    when :postgresql
      "~"
    else
      "REGEXP"
  end

  # Escopos
  scope :filters_params, lambda{ |params = {}|
    where(params[:accept_content_type] ? "upload_content_type #{REGEXP} '#{params[:accept_content_type]}'" : "")
    .where(params[:item_type] ? "item_type = '#{params[:item_type]}'" : "")
    .order(params[:order])
    .limit(params[:limit])
    .offset(params[:offset])
  }

  def title
    "#{self.upload_file_name} (#{self.upload_content_type})"
  end

  acts_as_taggable_on :tags

  def complete_list_name
    result = ""
    result << "#{self.upload_file_name} " if self.upload_file_name.present?
    result << "(#{self.source}, #{self.rights}) " if self.source.present? || self.rights.present?
    result << "- #{self.created_at}"
  end

  def unzip_files
    if self.upload_file_name.include?(".zip") && File.exists?(self.image.path)
      require 'zip/zip'
      zipped_files = Zip::ZipFile.open(self.image.path)
      int = 0
      zipped_files.each do |zipped_file|
        int = int + 1
        if zipped_file.file?
          zipped_file.extract("tmp/#{self.id}_unzipped_#{int}.jpg")
          Upload.create(:image => File.open("tmp/#{self.id}_unzipped_#{int}.jpg"),
                      :source => self.source,
                      :rights => self.rights,
                      :description => self.description,
                      :tag_list => self.tag_list.join(", ") )
          File.delete("tmp/#{self.id}_unzipped_#{int}.jpg")
        end
      end
    end
  end

  # Internal: Makes sure to only post-process files which are either pdf
  # or image files. Word documents would break file upload.
  #
  # No params
  #
  # Returns true for image or pdf files and false for everything else
  def image_file?
    !(self.upload_content_type =~ /^image.*/).nil? || !(self.upload_content_type =~ /pdf/).nil?
  end

  #Jquery File Uploads
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper
  # include I18n::Backend::Fallbacks
  # include I18n::Backend::Simple

  def to_jq_upload
    {
      "id"            => read_attribute(:id),
      "name"          => read_attribute(:upload_file_name),
      "content_type"  => read_attribute(:upload_content_type),
      "size"          => read_attribute(:upload_file_size),
      "updated_at"    => read_attribute(:updated_at),
      "created_at"    => read_attribute(:created_at),
      "images" =>  {
        "original"    => upload.url,
        "large"       => upload.url(:large  ),
        "big"         => upload.url(:big    ),
        "medium"      => upload.url(:medium ),
        "thumb"       => upload.url(:thumb  ),
        "mini"        => upload.url(:mini   ),
        # Logo
        "logo"        => upload.url(:logo   )
      },
      "url"           => upload.url(:original),
      "thumb"         => upload.url(:thumb),
      "delete_url"    => admin_upload_path(self),
      "delete_type"   => "DELETE",
      "i18n" => {
        "size"        => number_to_human_size(read_attribute(:upload_file_size)),
        "updated_at"  => I18n.l(read_attribute(:updated_at), format: :long),
        "created_at"  => I18n.l(read_attribute(:created_at), format: :long),
      }
    }
  end
end
