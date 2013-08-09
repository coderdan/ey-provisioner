module Ey
  module Provisioner
    class Connection
      EY_API_CLOUD_URL = "https://cloud.engineyard.com:443/"

      def initialize(token)
        @token      = token
        @http       = Excon.new(EY_API_CLOUD_URL)
      end

      def http_post(path, request)
        @http.post(
          :body    => JSON(:request => request.to_hash),
          :headers => headers,
          :path    => "/api/v2/#{path}",
          :expects => [200, 201, 202]
        )
      end

      private
        def headers
          {
            'Accept'           => 'application/json',
            'X-EY-Cloud-Token' => @token,
            'Content-type'     => 'application/json'
          }
        end
    end
  end
end
