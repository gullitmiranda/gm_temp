class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    :hash_secret  => "longSecretString",
                    :url          => "http://attachment.valeriatotti.com/:attachment/:id/:hash.:extension",
                    :path         => "/attachment/:attachment/:id/:hash.:extension"

  validates_attachment_size :data, :less_than => 100.megabytes
  validates_attachment_presence :data

	def url_thumb
	  @url_thumb ||= Ckeditor::Utils.filethumb(filename)
	end
end
