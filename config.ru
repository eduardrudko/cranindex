require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/reloader'

require 'active_record'
require 'yaml'
require 'json'

class BaseApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  env    = ENV['ENV'] || 'development'
  root   = File.expand_path '..', __FILE__
  config = YAML.load(File.read(File.join(root, 'db/config.yml')))

  ActiveRecord::Base.configurations = config
  ActiveRecord::Base.establish_connection env.to_sym
end

Dir.glob('./models/*.rb').sort.each do |file|
  require file
end

Dir.glob('./app/*.rb').sort.each do |file|
  require file
end

Dir.glob('./app/repositories/*.rb').sort.each do |file|
  require file
end

Dir.glob('./helpers/*.rb').sort.each do |file|
  require file
end

map '/' do
  run RootApp
end