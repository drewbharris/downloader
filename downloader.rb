require 'rack'
require 'liquid'

module Downloader
    URL_MAP = {
        '/' => proc {|env| Downloader.root(env)},
        '/admin/stats' => proc {|env| Downloader.stats(env)},
        '/admin/upload' => proc {|env| Downloader.upload(env)},
        '/public' => proc {|env| Rack::File.new(env['PATH_INFO']).call(env)}
    }

    TEMPLATE_DIR = './templates'

    def self.public(env)
        file_name = env['PATH_INFO'].split('/public')[-1]
        path = "#{PUBLIC_DIR}/#{file_name}"

        if File.exists?(path)
            return [200, {'Content-Type' => 'text/plain'}, [File.read(path)]]
        else
            not_found
        end
    end

    def self.stats(env)

        params = {

        }

        body = render(:stats, params)
        return [200, {'Content-Type' => 'text/plain'}, [body]]
    end

    def self.upload(env)

        params = {

        }

        body = render(:upload, params)
        return [200, {'Content-Type' => 'text/plain'}, ["stats page"]]
    end

    def self.root(env)
        file_name = env['PATH_INFO'].split('/')[-1]

        return [200, {'Content-Type' => 'text/plain'}, [""]]
    end

    def self.not_found
        return [404, {'Content-Type' => 'text/plain'}, ["not found"]]
    end

    def self.render(template_name, vars)
        template = File.read("#{TEMPLATE_DIR}/#{template_name.to_s}.liquid")
        return Liquid::Template.parse(template).render(vars)
    end
end


