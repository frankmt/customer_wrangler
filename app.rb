require 'rubygems'
require 'sinatra'

require_relative 'config/boot.rb'

set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "public") }
enable :static
set :views, Proc.new { File.join(root, "app/views") }

get '/' do
  redirect '/users'
end

post '/search' do
  redirect "/users?email=#{params[:email]}"
end

get '/users' do
  if params[:email]
    @email = params[:email]
    start_date = (DateTime.now - 90).iso8601
    end_date = (DateTime.now).iso8601
    @orders = Order.find_by_period(@email, start_date, end_date)
  else
    @orders = []
  end

  haml :'customers/show', layout: :layout
end
