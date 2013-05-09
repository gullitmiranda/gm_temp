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
require 'markdown'


module Rdcms
  class Engine < ::Rails::Engine
    isolate_namespace Rdcms
    initializer "rdcms.load_app_instance_data" do |app|
      #app.class.configure do
      #  #Pull in all the migrations from rdcms to the application
      #  config.paths['db/migrate'] += Rdcms::Engine.paths['db/migrate'].existent
      #end
    end
    config.to_prepare do
      #ActionController::Base.send :include, ArticlesController
      ApplicationController.helper(ApplicationHelper)
      ActionController::Base.helper(ApplicationHelper)
      DeviseController.helper(ApplicationHelper)
      Devise::SessionsController.helper(ApplicationHelper)
      Devise::PasswordsController.helper(ApplicationHelper)

      # ApplicationController.helper(ArticlesHelper)
      # ActionController::Base.helper(ArticlesHelper)
      # DeviseController.helper(ArticlesHelper)
      # Devise::SessionsController.helper(ArticlesHelper)
      # Devise::PasswordsController.helper(ArticlesHelper)
    end
  end
end
