require 'date'
require 'keen'
require 'intercom'

Dir[("app/**/*.rb")].each do |f|
  require_relative "../#{f}"
end
