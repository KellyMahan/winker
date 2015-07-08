module Winker
  module Connection
    def connection
      @connection ||= Faraday.new(Winker.endpoint) do |conn|
        conn.options[:timeout]      = 5
        conn.options[:open_timeout] = 2

        conn.request  :json
        conn.response :json, :content_type => /\bjson$/

        conn.authorization :bearer, Winker.access_token if Winker.access_token
        conn.response :detailed_logger, Winker.logger if Winker.logger

        conn.adapter Faraday.default_adapter # make requests with Net::HTTP
      end
    end
  
    def get(path, body = {})
      body = MultiJson.dump(body) if Hash === body
      connection.get(path) do |req|
        req.body = body if body
      end
    end
  
    def post(path, body = {})
      body = MultiJson.dump(body) if Hash === body
      connection.post(path) do |req|
        req.body = body if body
      end
    end
  
    def put(path, body = {})
      body = MultiJson.dump(body) if Hash === body
      connection.put(path) do |req|
        req.body = body if body
      end
    end
  end
end
