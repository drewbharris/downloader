require 'rack'

module Downloader
    URL_MAP = {
        '/' => proc {|env| Downloader.root(env)},
        '/admin/stats' => proc {|env| Downloader.stats(env)},
        '/admin/upload' => proc {|env| Downloader.upload(env)},
    }

    def self.stats(env)
        return [200, {'Content-Type' => 'text/plain'}, ["stats page"]]
    end

    def self.upload(env)
        return [200, {'Content-Type' => 'text/plain'}, ["stats page"]]
    end

    def self.root(env)
        file_name = env['PATH_INFO'].split("/")[-1]

        return [200, {'Content-Type' => 'text/plain'}, ["download #{file_name}"]]
    end

    def self.not_found(env)
        return [404, {'Content-Type' => 'text/plain'}, ["not found"]]
    end
end


