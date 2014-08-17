#encoding: utf-8
require 'resque'
require "redis-namespace"

$redis = Redis.new(:host => "localhost", :port => 6379 )

# rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
# rails_env = ENV['RAILS_ENV'] || 'production'

# resque_config = YAML.load_file(rails_root + '/config/resque.yml')

app_name = Rails.application.class.parent_name
Resque.redis.namespace = "resque:#{app_name}"