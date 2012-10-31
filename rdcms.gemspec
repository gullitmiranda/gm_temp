$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rdcms/version"
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rdcms"
  s.version     = Rdcms::VERSION
  s.authors     = ["Gullit Miranda"]
  s.email       = ["gullitmiranda@requestdev.com.br"]
  s.homepage    = "http://www.requestdev.com.br/"
  s.summary     = "Sistema de controle de conteúdo da Requestdev"
  s.description = "This is the Basic Module of Rdcms. It Offers Devise, ActiveAdmin, an Article-Module, a Menu-Module, and global Settings for an CMS"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["CC-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
  s.add_dependency "jquery-rails"
  s.add_dependency "jqueryui_rails"
  s.add_dependency 'devise'
  s.add_dependency 'activeadmin-cancan'
  s.add_dependency "activeadmin"
  s.add_dependency 'sunspot_rails'
  s.add_dependency 'sunspot_solr'
  #s.add_dependency 'meta_search', '~> 1.1.3'
  s.add_dependency 'sprockets'
  #s.add_dependency "sass-rails", "~> 3.2.1"
  s.add_dependency "sass-rails"
  s.add_dependency "compass-rails"
  s.add_dependency "execjs"
  s.add_dependency "therubyracer"
  s.add_dependency "friendly_id"#, ">= 4.0.6"
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-openid"
  s.add_dependency 'oa-oauth'
  s.add_dependency 'oa-openid'
  s.add_dependency "cancan", "1.6.7"
  s.add_dependency "ancestry"
  s.add_dependency 'meta-tags'
  s.add_dependency 'paperclip'
  s.add_dependency 'uglifier'
  s.add_dependency 'exception_notification'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'liquid'
  s.add_dependency 'rubyzip'
  s.add_dependency 'geocoder'
  s.add_dependency 'paper_trail'
  s.add_dependency 'sidekiq'
  s.add_dependency 'sinatra'
  s.add_dependency 'slim'
  s.add_dependency 'whenever'
  # s.add_dependency "pdfkit"
  # s.add_dependency 'wkhtmltopdf-binary'
  # s.add_dependency "wicked_pdf"
  s.add_development_dependency "mysql2"
  s.add_development_dependency 'annotate'
  s.add_development_dependency 'guard-annotate'
  s.add_development_dependency 'pry'

  
  
end
