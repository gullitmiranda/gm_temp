module UploadsHelper
  # include ActionController::UrlFor
  # include ActionView::Helpers
  # include Rails.application.routes.url_helpers
  # include ActionView::AssetPaths
  # include ActionView::Helpers::AssetTagHelper
  # include Sprockets::Helpers::IsolatedHelper
  
  def render_list_all_images(upload = nil)
    html = ""
    return html unless upload and upload.image_file?
    
    html << image_tag(upload.upload(:medium))
    links = []
    [:original, :large, :big, :medium, :thumb, :mini].each do |size|
      # links << FastImage.size(upload.upload(size).to_s)
      # link_to() do
      #   t(".#{size}")
      # end
    end
    html << content_tag(:div, links.join("\n"), class: "links_box")

  end
end
