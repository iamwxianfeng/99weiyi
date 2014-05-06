require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

# source 'http://rubygems.org'
source 'http://ruby.taobao.org'

gem 'rails', '3.1.1'
gem 'jquery-rails'
gem 'mysql2', '0.3.10'
gem "omniauth", '1.1.0'
gem 'omniauth-weibo-oauth2', '0.2.0'
gem 'will_paginate', '3.0.4'
# gem 'omniauth-qq', '0.2.1'
# gem 'omniauth-qq-connect', '0.1.0'
gem 'omniauth-qq', :git => 'git://github.com/blankyao/omniauth-qq.git'
# gem 'rails_admin','0.4.9' #https://github.com/sferik/rails_admin
gem 'thin', '~> 1.5.1' # or mongrel
gem 'unicorn', '~> 4.6.3'


group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'spork' , '0.9.0.rc7'
end



group :development do
  gem "better_errors" #https://github.com/charliesome/better_errors
  # gem 'capistrano'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# install a Javascript runtime for linux
if HOST_OS =~ /linux/i
  gem 'therubyracer', '>= 0.9.8'
end

gem "rspec-rails", ">= 2.8.0.rc1", :group => [:development, :test]
gem "factory_girl_rails", ">= 1.3.0", :group => :test
gem "guard", ">= 0.6.2", :group => :development
case HOST_OS
  when /darwin/i
    gem 'rb-fsevent', :group => :development
    gem 'growl', :group => :development
  when /linux/i
    gem 'libnotify', :group => :development
    gem 'rb-inotify', :group => :development
  when /mswin|windows/i
    gem 'rb-fchange', :group => :development
    gem 'win32console', :group => :development
    gem 'rb-notifu', :group => :development
end
gem "guard-bundler", ">= 0.1.3", :group => :development
gem "guard-rails", ">= 0.0.3", :group => :development
gem "guard-livereload", ">= 0.3.0", :group => :development
gem "guard-rspec", ">= 0.4.3", :group => :development
gem "devise", ">= 1.4.9"
gem "rails-footnotes", ">= 3.7", :group => :development
gem 'passenger'

group :development, :test do
  gem 'pry', '~> 0.9.10' # https://github.com/pry/pry
  gem 'pry-nav', '~> 0.2.3' # https://github.com/nixme/pry-nav
end