class GalleriesController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json
  def index
    @galleries = Gallery.visible
    respond_with @galleries
  end

  def show
    @gallery = Gallery.find(params[:id])
    @gallery.visit! :by => request.try(:remote_ip)

    respond_with @gallery
  end
end
