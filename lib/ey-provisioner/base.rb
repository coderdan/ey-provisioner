module Ey
  module Provisioner
    class Base
      EY_API_CLOUD_URL = "https://cloud.engineyard.com:443/"

      def initialize(token)
        @token      = token
        @connection = Excon.new(EY_API_CLOUD_URL)
      end

      private
        def body_from_options(options)
          request = {}
          request[:role]          = options[:role] || 'util'
          request[:name]          = options[:name] if options.has_key?(:name)
          request[:instance_size] = options[:instance_size].to_s if options.has_key?(:instance_size)
          request[:snapshot_id]   = options[:snapshot_id] if options.has_key?(:snapshot_id)
          JSON('request' => request)
        end

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
