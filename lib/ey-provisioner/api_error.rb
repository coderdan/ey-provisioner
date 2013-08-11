module Ey
  module Provisioner
    class APIError < RuntimeError
      attr_reader :errors, :request, :status

      def initialize(error)
        @error = error
        parse_error
      end

      def message
        if @status
          "#{@status}: #{error_message}"
        else
          @error.message
        end
      end

      # Specific EngineYard API error
      def error_message
        if @errors
          @errors.map { |(k,v)|
            "#{k} #{v.join(',')}"
          }.join("; ")
        end
      end

      private
        def parse_error
          if @error.respond_to?(:response) && @error.response.body.present?
            body_hash = JSON(@error.response.body)
            @status   = body_hash.fetch('status', 'unknown')
            @errors   = body_hash['errors']
            @request  = body_hash['request']
          end
        end
    end
  end
end
