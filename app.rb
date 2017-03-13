require 'rubygems'
require 'sinatra'

require_relative 'config/boot.rb'

set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "public") }
enable :static
set :views, Proc.new { File.join(root, "app/views") }

get '/' do
  haml :'search/new', layout: :layout
end

post '/search' do
  redirect "/users?email=#{params[:email]}"
end

get '/users' do
  if params[:email]
    @email = params[:email]
    @user = User.find_by_email(params[:email])
  end

  if @user
    start_date = (DateTime.now - 30).iso8601
    end_date = (DateTime.now).iso8601
    @orders = Order.find_by_period(@user.email, start_date, end_date)
    start_date = (DateTime.now - 7).iso8601
    end_date = (DateTime.now).iso8601
    @recent_activity = @user.activity_feed(start_date, end_date).sort_by{|event| event.date}.reverse
    haml :'customers/show', layout: :layout
  else
    haml :'search/new', layout: :layout
  end

end
