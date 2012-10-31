module Rdcms
  class ApplicationController < ActionController::Base

    before_filter :set_locale

    def set_locale
      unless Rails.env == "test"
        I18n.locale = session[:locale]
      end
    end

    rescue_from CanCan::AccessDenied do |exception|
      if can?(:read, Rdcms::Article)
        redirect_to root_url, :alert => exception.message
      else
        redirect_to "/admin", :alert => exception.message
      end
    end

    def s(name)
      if name.present?
        Rdcms::Setting.for_key(name)
      end
    end


    def initialize_article(current_article)
      Rdcms::Article::LiquidParser["current_article"] = @article
      set_meta_tags :site => s("rdcms.page.default_title_tag"),
                    :title => current_article.metatag("Title Tag"),
                    :description => current_article.metatag("Meta Description"),
                    :keywords => current_article.metatag("Keywords"),
                    :canonical => current_article.canonical_url,
                    :noindex => current_article.robots_no_index,
                    :open_graph => {:title => current_article.metatag("OpenGraph Title"),
                                  :description => current_article.metatag("OpenGraph Description"),
                                  :type => current_article.metatag("OpenGraph Type"),
                                  :url => current_article.metatag("OpenGraph URL"),
                                  :image => current_article.metatag("OpenGraph Image")}
    end

  end
end
