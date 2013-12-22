require './config'
require 'rack'
require 'rack/streaming_proxy'
require 'rack/uploads'
require 'logger'
require './lib/controller'
require 'rack/handler'

LOGFILE = "rack.log"
PORT = 9292

controller = Rack::URLMap.new(Controller::URL_MAP)
builder = Rack::Builder.new do
	use(Rack::Uploads)
	use(Rack::CommonLogger)
	use(Rack::Static, {:urls => ["/img", "/js", "/css"], :root => "public"})
	use(Rack::StreamingProxy) do |request|
		if !request.path.match(/\/admin(.*)/)
			file_name = request.path.split('/')[-1]

			# check if this is a file and if the download is allowed, note the download and serve it out to nginx
			allowed = Downloader.process(file_name)

			if allowed
				"http://localhost:#{Cfg::NGINX_PORT}/files/#{file_name}"
			end
		end
	end
	Logger.new(LOGFILE)
	run(controller)
end

Rack::Handler.get(:puma).run(builder, :Port => PORT)