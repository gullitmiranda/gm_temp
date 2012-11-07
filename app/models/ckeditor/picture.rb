class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :hash_secret  => "longSecretString",
                    :url          => "http://images.valeriatotti.com/:attachment/:id/:hash.:extension",
                    :path         => "/images/:attachment/:id/:hash.:extension",
	                  :styles => { :content => '800>', :thumb => '118x100#' }
	
	validates_attachment_size :data, :less_than => 2.megabytes
	validates_attachment_presence :data
	
	def url_content
	  url(:content)
	end
end
