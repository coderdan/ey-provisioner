module Ey
  module Provisioner
    class Environment < Base
      def add_instance(env_id, options = {})
        # TODO: Use a validator on the options (check instance size etc)
        @connection.post(
          :body    => body_from_options(options),
          :headers => headers,
          :path    => "/api/v2/environments/#{env_id}/add_instances",
          :expects => [200, 201, 202]
        )
      rescue Excon::Errors::Error => e
        raise APIError.new(e.message)
      end
    end
  end
end
