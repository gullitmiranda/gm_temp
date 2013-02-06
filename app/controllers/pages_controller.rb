class PagesController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json

  def index
    @pages = Page.all.visible
    respond_with @pages
  end

  def show
    @page = Page.visible.find(params[:id])
    @page.visit! :by => request.try(:remote_ip)

    respond_with @page
  end
end
