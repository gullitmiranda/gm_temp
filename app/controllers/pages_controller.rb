class PagesController < ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :json
  def show
    @page = Page.find(params[:id])
    respond_with @page
  end
end
