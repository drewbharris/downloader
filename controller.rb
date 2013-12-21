require 'rack'
require './lib/template'
require './lib/downloader'

module Controller
    URL_MAP = {
        '/' => proc {|env| Downloader.download(env)},
        '/admin/stats' => proc {|env| Downloader.stats(env)},
        '/admin/upload' => proc {|env| Downloader.upload(env)}
    }

    def self.stats(env)
        params = {

        }

        body = Template.render(:stats, params)
        return [200, {'Content-Type' => 'text/plain'}, [body]]
    end

    def self.upload(env)
        params = {

        }

        body = Template.render(:upload, params)
        return [200, {'Content-Type' => 'text/plain'}, ["stats page"]]
    end

    def self.download(env)
        file_name = env['PATH_INFO'].split('/')[-1]

        download_ready = Downloader.process(file_name)

        if !download_ready
            return [401, {'Content-Type' => content_type}, ["Unauthorized"]]
        end

        return [302, {'Location' => "nginx_redirect_to_file"}, [""]]
    end

    def self.not_found
        return [404, {'Content-Type' => 'text/plain'}, ["not found"]]
    end

end


