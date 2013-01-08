class PartnersController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :json
  def index
    @partners  = Partner.visible.ordained
    respond_with @partners
  end
end
