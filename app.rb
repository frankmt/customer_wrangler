require 'rubygems'
require 'sinatra'

Dir[("app/**/*.rb")].each do |f|
  require_relative f
end

set :views, Proc.new { File.join(root, "app/views") }

get '/' do
   haml :'customers/show'
end
