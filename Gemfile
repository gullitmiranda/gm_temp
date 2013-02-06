source "http://rubygems.org"
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"


gem "devise", "~> 2.1.2"
gem "activeadmin", "~> 0.5.0", :require => "activeadmin"
gem 'execjs'
gem 'therubyracer'
gem 'omniauth'
gem 'omniauth-openid'
gem 'oa-oauth', :require => 'omniauth/oauth'
gem 'oa-openid', :require => 'omniauth/openid'
gem 'coffee-rails', '~> 3.2.0'
gem 'uglifier', '>= 1.0.3'
gem 'meta-tags', :require => 'meta_tags'
gem 'sass-rails'
gem 'compass-rails'
gem 'memcache-client'
gem 'nokogiri', '~> 1.5.3'
gem 'cancan', "1.6.7"

gem "rspec-rails", :group => [:test, :development] # rspec in dev so the rake tasks run properly
gem "faker", :group => [:test, :development] # rspec in dev so the rake tasks run properly
gem "paper_trail"
gem 'sunspot_rails'
gem 'sunspot_solr'
# gem 'pdfkit'
# gem 'wkhtmltopdf-binary'
# gem 'wicked_pdf'
gem "sidekiq", "~> 2.7.0"
gem 'sinatra', :require => false
gem 'slim'
#gem 'bullet'  testing for slow queries
gem 'geokit'
gem 'fastimage'

gem "inherited_resources", "~> 1.3.1"

# Upload de arquivos
gem "paperclip", "~> 3.3.0"
gem "paperclipftp", "~> 0.2.4"
gem 'contact_us', '~> 0.4.0.beta', :git => 'git://github.com/gullitmiranda/contact_us.git'
gem 'friendly_id'
gem 'globalize3'
gem "globalize3_helpers", :git => 'git://github.com/gullitmiranda/globalize3_helpers.git'

gem 'contact_us', '~> 0.4.0.beta', :git => 'git://github.com/gullitmiranda/contact_us.git'
gem "meta_search", "~> 1.1.3"
gem "awesome_nested_set", "~> 2.1.5"
gem "jquery-fileupload-rails"
gem "best_in_place", "~> 2.0.3", git: "git://github.com/bernat/best_in_place.git"
gem 'acts-as-taggable-on', '~> 2.3.1'
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
  #gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'guard-annotate'
  gem 'pry'
  gem 'pry-nav'
  gem 'brakeman'
  gem 'hirb'
  #gem 'git-pivotal', '~> 0.8.2'
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
  gem 'rb-fsevent', '~> 0.9.1' #:git => 'git://github.com/ttilley/rb-fsevent.git', :branch => 'pre-compiled-gem-one-off'
  gem 'growl'
  gem 'launchy'
  gem 'faker'
end
