module Ey
  module Provisioner
    # Maintains a connection representation (stateless) to the EY API
    # Supports V2 of the API
    class Connection
      EY_API_CLOUD_URL = "https://cloud.engineyard.com:443/"

      # Create a connection
      # @param token [String] the EY token
      def initialize(token)
        @token      = token
        @http       = Excon.new(EY_API_CLOUD_URL)
      end

      # Get an environment instance
      #
      # @param id [Integer] the environment ID
      # @return [Environment]
      def environment(id)
        Environment.new(self, id)
      end

      # Perform an API POST to the path
      #
      # @param path [String] the partial path (ie; everything after /api/v2/)
      # @param request [Request] a request object
      # @return [Excon::Response]
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
