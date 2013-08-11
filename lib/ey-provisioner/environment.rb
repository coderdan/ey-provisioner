module Ey
  module Provisioner
    class Environment
      def initialize(connection, env_id)
        @connection = connection
        @env_id     = env_id
      end

      def remove_instances(options = {})
        process_post(path_for(:remove_instances), options)
      end

      def add_instance(options = {})
        process_post(path_for(:add_instances), options)
      end

      # TODO: Handle add and remove status
      def status(options = {})
        api_error_handler do
          request = Request.new(options)
          @connection.http_get(
            :headers => @connection.headers,
            :path    => "/api/v2/environments/#{@env_id}/add_instances",
            :expects => [200, 201, 202]
          )
        end
      end

      private
        def path_for(which)
          "environments/#{@env_id}/#{which}"
        end

        def api_error_handler
          begin
            yield if block_given?
          rescue Excon::Errors::Error => e
            raise APIError.new(e)
          end
        end

        def process_post(path, options)
          api_error_handler do
            request  = Request.new(options)
            response = @connection.http_post(path, request)
            Instance.new(JSON(response.body)['instance'])
          end
        end
    end
  end
end
