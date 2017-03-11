Dir[("app/**/*.rb")].each do |f|
  require_relative "../#{f}"
end

require 'keen'
