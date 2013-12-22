require 'rack'
require 'json'
require './lib/template'
require './lib/downloader'
require 'pp'

module Controller
    URL_MAP = {
        '/' => proc {|env| Controller.index(env)},
        '/admin/stats' => proc {|env| Controller.stats(env)},
        '/admin/upload' => proc {|env| Controller.upload(env)},
        '/api/v1/upload' => proc {|env| API.upload(env)}
    }

    def self.stats(env)
        body = Template.render(:stats, {
        })
        return [200, {'Content-Type' => 'text/plain'}, [body]]
    end

    def self.upload(env)
        body = Template.render(:upload, {
        })
        return [200, {'Content-Type' => 'text/html'}, [body]]
    end

    def self.index(env)

        request = Rack::Request.new(env)

        if request.params['error'] == 'not_found'
            not_found
        end

        pp request.params

        body = Template.render(:index, {
        })
        return [200, {'Content-Type' => 'text/plain'}, ["root"]]
    end

    def self.not_found
        return [404, {'Content-Type' => 'text/plain'}, ["not found"]]
    end
end

module API
    def self.upload(env)
        upload = env['rack.uploads'][0]

        filename = upload.filename.gsub(' ', '_')
        upload.mv("#{Cfg::NGINX_PATH}/files/#{filename}")
        File.chmod(0644, "#{Cfg::NGINX_PATH}/files/#{filename}")
        return [200, {'Content-Type' => 'application/json'}, [{
            'filename' => "#{filename}"
        }.to_json]]
    end
end


