class Controller
    def self.stats(request)
        response = Rack::Response.new

        response['Content-Type'] = 'text/plain'
        response.status = 200
        response.write("stats")

        return response
    end

    def self.upload(request)
        response = Rack::Response.new

        response['Content-Type'] = 'text/plain'
        response.status = 200
        response.write("upload")

        return response
    end

    def self.root(request)
        response = Rack::Response.new

        response['Content-Type'] = 'text/plain'
        response.status = 200
        response.write("root")

        return response
    end

    def self.not_found(request)
        response = Rack::Response.new

        response['Content-Type'] = 'text/plain'
        response.status = 404
        response.write("not found")
        
        return response
    end
end