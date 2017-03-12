require 'date'
require 'keen'
require 'intercom'

require 'pry'

Dir[("app/**/*.rb")].each do |f|
  require_relative "../#{f}"
end
