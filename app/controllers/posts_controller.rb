class PostsController < ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :json
  def index
    @posts = Post.visible
    respond_with @posts
  end
  
  def show
    @post = Post.find(params[:id])
    respond_with @post
  end
end
