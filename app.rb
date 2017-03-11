require 'rubygems'
require 'sinatra'

Dir[("app/**/*.rb")].each do |f|
  require_relative f
end

get '/' do
  erb 'Hello'
end
