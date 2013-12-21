require 'rack'
require 'logger'
require './controller'

LOGFILE = "rack.log"
PORT = 9292

controller = Rack::URLMap.new(Downloader::URL_MAP)
builder = Rack::Builder.new do
	use(Rack::CommonLogger)
	use(Rack::Static, {:urls => ["/img", "/js", "/css"], :root => "public"})
	Logger.new(LOGFILE)
	run(controller)
end

Rack::Handler::WEBrick.run(builder, :Port => PORT)