require 'rack'
require 'logger'
require './downloader'

# static_app = Rack::Static.new(:urls => ["/public/images", "/public/js", "/public/css"], :root => "public")

rack_app = Rack::URLMap.new(Downloader::URL_MAP)
builder = Rack::Builder.new do
  use Rack::CommonLogger
  Logger.new('rack.log')
  run rack_app
end

Rack::Handler::WEBrick.run(builder, :Port => 9292)