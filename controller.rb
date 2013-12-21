require 'rack'
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

    NGINX_PORT = 9293
    NGINX_ROOT = '/usr/local/var/www'

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
        upload.mv("#{Controller::NGINX_ROOT}/files/#{upload.filename}")
        File.chmod(0644, "#{Controller::NGINX_ROOT}/files/#{upload.filename}")
        return [200, {'Content-Type' => 'text/html'}, ["/files/#{upload.filename}"]]
    end
end


