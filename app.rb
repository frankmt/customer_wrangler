require 'rubygems'
require 'sinatra'

Dir[("app/**/*.rb")].each do |f|
  require_relative f
end

set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "public") }
enable :static
set :views, Proc.new { File.join(root, "app/views") }

get '/' do
   haml :'customers/show'
end
