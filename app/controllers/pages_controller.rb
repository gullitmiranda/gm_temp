class PagesController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json

  def index
    @pages = Page.all.visible
    respond_with @pages
  end

  def show
    @page = Page.visible.find(params[:id])
    respond_with @page
  end
end
