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



module Rdcms
  class Engine < ::Rails::Engine
    isolate_namespace Rdcms
    config.to_prepare do
      ApplicationController.helper(Rdcms::ApplicationHelper)
      ActionController::Base.helper(Rdcms::ApplicationHelper)      
      DeviseController.helper(Rdcms::ApplicationHelper)           
      Devise::SessionsController.helper(Rdcms::ApplicationHelper)           
      Devise::PasswordsController.helper(Rdcms::ApplicationHelper)      
      
      ApplicationController.helper(Rdcms::ArticlesHelper)
      ActionController::Base.helper(Rdcms::ArticlesHelper)  
      DeviseController.helper(Rdcms::ArticlesHelper)               
      Devise::SessionsController.helper(Rdcms::ArticlesHelper)  
      Devise::PasswordsController.helper(Rdcms::ArticlesHelper)        
    end
  end
end
