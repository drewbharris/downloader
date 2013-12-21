require 'rack'
require './lib/template'
require './lib/downloader'

module Controller
    URL_MAP = {
        '/' => proc {|env| Controller.root(env)},
        '/admin/stats' => proc {|env| Controller.stats(env)},
        '/admin/upload' => proc {|env| Controller.upload(env)}
    }

    NGINX_PORT = 9293
    NGINX_ROOT = '/usr/local/var/www'

    def self.stats(env)
        params = {

        }

        body = Template.render(:stats, params)
        return [200, {'Content-Type' => 'text/plain'}, [body]]
    end

    def self.upload(env)
        params = {

        }

        # put uploaded file in NGINX_ROOT/files

        body = Template.render(:upload, params)
        return [200, {'Content-Type' => 'text/plain'}, ["stats page"]]
    end

    def self.root(env)

        return [200, {'Content-Type' => 'text/plain'}, ["root"]]
    end

    def self.not_found
        return [404, {'Content-Type' => 'text/plain'}, ["not found"]]
    end

end


