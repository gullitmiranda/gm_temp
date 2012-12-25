class PublicationsController < ApplicationController
  load_and_authorize_resource
  layout "full_screen"
  
  respond_to :html, :json, :pdf
  def index
    @catalogue  = Publication.publication_root.visible.ordained.catalogue
    @campaign   = Publication.publication_root.visible.ordained.campaign
    @publications = [@catalogue, @campaign]
    respond_with @publications
  end
  
  def show
    @publication = Publication.visible.find(params[:id])
    @pages = @publication.children.visible.ordained

    respond_with(@publication) do |format|
      format.pdf {
        render :pdf => "#{@publication.slug}"
      }
    end
  end
end
