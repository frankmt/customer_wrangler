Dir[("app/**/*.rb")].each do |f|
  require_relative "../#{f}"
end

RSpec.configure do |config|
  config.order = "random"
end
