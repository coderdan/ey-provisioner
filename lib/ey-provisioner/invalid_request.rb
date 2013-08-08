module Ey
  module Provisioner
    class InvalidRequest < StandardError
      attr_reader :request
      def initialize(request)
        @request = request
        errors = @request.errors.full_messages.join(", ")
        super("Invalid Request: #{errors}")
      end
    end
  end
end
