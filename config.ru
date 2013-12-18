require 'logger'
require './app'

rack_app = Rack::Builder.new do
	use(Rack::CommonLogger)
	Logger.new('rack.log')

	map("/") do
		run Proc.new {|env| Controller.root(Rack::Request.new(env))}
	end

	map("/admin") do

		use(Rack::Auth::Basic, "Restricted Area") do |user, password|
			user == 'admin' && password == 'password'
		end

		map("/upload") do
	  		run Proc.new {|env| Controller.upload(Rack::Request.new(env))}
		end
		map("/stats") do
		  	run Proc.new {|env| Controller.stats(Rack::Request.new(env))}
		end

	end
end
Rack::Handler::WEBrick.run rack_app, :Port => 9292