class MoviesController < ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :json

  def index
    if request.xhr?
      @movies = get_video_list
      
      respond_with @movies do |format|
        format.html { render :layout => false }
      end
    end
  end
  def render_list
    @movies = get_video_list
    respond_with @movies
  end

  private
  
  def get_video_list(start=1, limit=nil)
    object = eval("Youtube::#{Setting.for_key("rdcms.videos.object").classify}")
    data = object.find(
      scope: Setting.for_key("rdcms.videos.scope"),
      :params => {
        :"max-results" => limit || Setting.for_key("rdcms.videos.limit"),
        :v => Setting.for_key("rdcms.videos.api-version")
      })
  end
end
