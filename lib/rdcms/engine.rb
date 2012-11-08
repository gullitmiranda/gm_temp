require "friendly_id"
require 'ancestry'
require 'devise'
require 'cancan'
require 'meta_tags'
require 'sass'
require 'sprockets'
require 'sprockets/railtie'
require 'sass-rails'
require 'acts-as-taggable-on'
require 'paperclip'
require 'liquid'
require 'geocoder'
require "paper_trail"
require 'sunspot_rails'
require 'sunspot_solr'
# require "pdfkit"
# require 'wkhtmltopdf-binary'
# require "wicked_pdf"
require 'sidekiq'
require 'sinatra'
require 'slim'
require 'geokit'
require 'fastimage'


module Rdcms
  class Engine < ::Rails::Engine
    isolate_namespace Rdcms
    config.to_prepare do
      ApplicationController.helper(ApplicationHelper)
      ActionController::Base.helper(ApplicationHelper)      
      DeviseController.helper(ApplicationHelper)           
      Devise::SessionsController.helper(ApplicationHelper)           
      Devise::PasswordsController.helper(ApplicationHelper)      
      
      ApplicationController.helper(ArticlesHelper)
      ActionController::Base.helper(ArticlesHelper)  
      DeviseController.helper(ArticlesHelper)               
      Devise::SessionsController.helper(ArticlesHelper)  
      Devise::PasswordsController.helper(ArticlesHelper)        
    end
  end
end
