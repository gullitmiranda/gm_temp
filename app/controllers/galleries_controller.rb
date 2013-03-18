class GalleriesController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json
  def index

    if params[:tag]
      @search = Gallery.tagged_with(params[:tag]).list_all.search(params[:search])
      @galleries = @search
    else
      @search = Gallery.list_all.search(params[:search])
      @galleries = @search
    end

    respond_with @galleries
  end

  def show
    @gallery = Gallery.find(params[:id])
    @gallery.visit! :by => request.try(:remote_ip)

    respond_with @gallery
  end
end
