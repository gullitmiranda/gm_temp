class PublicationsController < ApplicationController
  load_and_authorize_resource
  layout "full_screen"

  respond_to :html, :json, :pdf
  def index
    @catalogue  = Publication.publication_root.visible.ordained.catalogue.all
    @campaign   = Publication.publication_root.visible.ordained.campaign.all
    @publications = [@catalogue, @campaign]
    respond_with @publications
  end

  def show
    @publication = Publication.visible.find(params[:id])
    @pages = @publication.children.visible.ordained
    @publication.visit! :by => request.try(:remote_ip)

    respond_with(@publication) do |format|
      format.pdf {
        render :pdf => "#{@publication.slug}"
      }
    end
  end
end
