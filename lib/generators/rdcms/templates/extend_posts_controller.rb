module ExtendPostsController
  def before_init
    @post = Post.find(params[:id])
    @post.visit! :by => request.try(:remote_ip)

    # respond_with @post
  end

  def after_init
    #::Rails.logger.info("********************************** - AFTER-INIT")
  end

  def after_index
    #@list_of_articles accessible
    #::Rails.logger.info("********************************** - AFTER-INDEX")
  end

  def before_render
    #::Rails.logger.info("********************************** - BEFORE-RENDER")
  end
end
