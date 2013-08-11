module Ey
  module Provisioner
    class Environment
      def initialize(connection, env_id)
        @connection = connection
        @env_id     = env_id
      end

      # Remove instances from the environment
      #
      # @param options [Hash] attributes to define what to remove (eg; name, role). See EY docs
      def remove_instances(options = {})
        process_post(path_for(:remove_instances), options)
      end

      # Add an instance to the environment
      #
      # @param options [Hash] attributes to define the server to add (eg; name, role). See EY docs
      def add_instance(options = {})
        process_post(path_for(:add_instances), options)
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
