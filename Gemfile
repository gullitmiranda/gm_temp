if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source "http://rubygems.org"
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"


gem 'devise', :git => "git://github.com/plataformatec/devise.git"
gem 'activeadmin', :git => "git://github.com/ikusei/active_admin.git", :require => "activeadmin"
gem 'acts-as-taggable-on', :git => 'git://github.com/mbleigh/acts-as-taggable-on.git'
gem 'execjs'
gem 'therubyracer', '~> 0.10.2'
gem "friendly_id"
gem 'omniauth'
gem 'omniauth-openid'
gem 'oa-oauth', :require => 'omniauth/oauth'
gem 'oa-openid', :require => 'omniauth/openid'
gem 'coffee-rails', '~> 3.2.0'
gem 'uglifier', '>= 1.0.3'
gem 'meta-tags', :require => 'meta_tags'
# gem 'meta-tags', :require => 'meta_tags', :git => "git://github.com/jazzgumpy/meta-tags.git"
gem 'sass-rails'
gem 'compass-rails'
gem 'memcache-client'
gem 'nokogiri', '~> 1.5.3'
gem 'cancan'

gem "rspec-rails", :group => [:test, :development] # rspec in dev so the rake tasks run properly
gem "faker", :group => [:test, :development] # rspec in dev so the rake tasks run properly
gem "paper_trail"
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'sidekiq'
gem 'sinatra', :require => false
gem 'slim'
gem 'geokit'
gem 'fastimage'

gem "inherited_resources", "~> 1.3.1"

# Upload de arquivos
gem "paperclip", "~> 3.3.0"
gem "paperclipftp", "~> 0.2.4"
gem 'contact_us', '~> 0.4.0.beta', :git => 'git://github.com/gullitmiranda/contact_us.git'
gem 'globalize3'
gem "globalize3_helpers", :git => 'git://github.com/gullitmiranda/globalize3_helpers.git'

gem 'contact_us', '~> 0.4.0.beta', :git => 'git://github.com/gullitmiranda/contact_us.git'
gem "meta_search", "~> 1.1.3"
gem "awesome_nested_set", "~> 2.1.5"
gem "jquery-fileupload-rails"
gem "best_in_place", "~> 2.0.3", git: "git://github.com/bernat/best_in_place.git"
gem "ckeditor", "~> 3.7.3"
gem "string_base64", "~> 1.0.1"
gem "email_validator", "~> 1.3.0"
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'client_side_validations-formtastic'

# Estatísticas
gem "is_visitable", "~> 0.1.0", :git => "git://github.com/gullitmiranda/is_visitable.git"

group :assets do
  gem "twitter-bootstrap-rails", "~> 2.1.3"
end


group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'guard-annotate'
  gem 'pry'
  gem 'pry-nav'
  gem 'brakeman'
  gem 'hirb'
  gem "powder"
end

group :test do
  gem 'mysql2'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'factory_girl'
  gem "factory_girl_rails"
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'guard', '~> 1.1.1'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-livereload'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'growl'
  gem 'launchy'
  gem 'faker'
  gem 'shoulda-matchers'
end
