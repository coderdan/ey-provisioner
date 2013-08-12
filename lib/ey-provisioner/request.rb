module Ey
  module Provisioner
    # Implement the presenter pattern for API requests
    class Request
      include ActiveModel::Validations

      attr_accessor :role
      attr_accessor :name
      attr_accessor :instance_size
      attr_accessor :snapshot_id
      attr_accessor :availability_zone
      attr_reader   :volume_size

      validates :role,
                :presence => true,
                :inclusion => { :in => %w(app util) }

      validates :instance_size,
                :inclusion => { :in => Instance::TYPES },
                :allow_nil => true

      # Create a new request
      #
      # @param options [Hash]
      def initialize(options = {})
        options.each do |(attr,value)|
          send("#{attr}=", value)
        end
        self.role ||= 'util'
      end

      def volume_size=(arg)
        @volume_size = arg.to_s
      end

      def instance_size=(size)
        # Ensure symbols are converted to strings
        @instance_size = size.to_s unless size.nil?
      end

      # A hash representation of the request
      def to_hash
        raise InvalidRequest.new(self) if !valid?
        {}.tap do |request|
          request[:role] = self.role
          [ :name, :instance_size, :volume_size, :snapshot_id, :availability_zone ].each do |attr|
            request[attr] = send(attr) unless send(attr).nil?
          end
        end
      end
    end
  end
end
