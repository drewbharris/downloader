require 'rack'
require 'rack/streaming_proxy'
require 'rack/uploads'
require 'logger'
require './controller'

LOGFILE = "rack.log"
PORT = 9292

controller = Rack::URLMap.new(Controller::URL_MAP)
builder = Rack::Builder.new do
	use(Rack::Uploads)
	use(Rack::CommonLogger)
	use(Rack::Static, {:urls => ["/img", "/js", "/css"], :root => "public"})
	use(Rack::StreamingProxy) do |request|
		if request.path.start_with?("/files")
			file_name = request.path.split('/files/')[-1]

			# check if the download is allowed, note the download and serve it out to nginx
			if Downloader.process(file_name)
				"http://localhost:#{Controller::NGINX_PORT}/files/#{file_name}"
			end

		end
	end
	Logger.new(LOGFILE)
	run(controller)
end

Rack::Handler::WEBrick.run(builder, :Port => PORT)