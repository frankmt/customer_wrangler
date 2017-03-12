require 'rubygems'
require 'sinatra'

require_relative 'config/boot.rb'

set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "public") }
enable :static
set :views, Proc.new { File.join(root, "app/views") }

get '/' do
  start_date = (DateTime.now - 7).iso8601
  end_date = (DateTime.now).iso8601
  @orders = Order.find_by_period("test@user.com", start_date, end_date)

  haml :'customers/show', layout: :layout
end
