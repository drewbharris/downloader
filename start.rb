require 'rack'
require './downloader'

rack_app = Rack::URLMap.new(Downloader::URL_MAP)
Rack::Handler::WEBrick.run(rack_app, :Port => 9292)