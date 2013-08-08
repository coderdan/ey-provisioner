module Ey
  module Provisioner
    class Environment < Base
      def add_instance(env_id, options = {})
        request = Request.new(options)
        @connection.post(
          :body    => JSON(request.body),
          :headers => headers,
          :path    => "/api/v2/environments/#{env_id}/add_instances",
          :expects => [200, 201, 202]
        )
      rescue Excon::Errors::Error => e
        raise APIError.new(e)
      end
    end
  end
end
