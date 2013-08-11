module Ey
  module Provisioner
    # Represents an EY instance
    class Instance
      attr_accessor :id
      attr_accessor :amazon_id
      attr_accessor :bootstrapped_at
      attr_accessor :chef_status
      attr_accessor :name
      attr_accessor :private_hostname
      attr_accessor :public_hostname
      attr_accessor :role
      attr_accessor :status

      TYPES = %w(
        small
        small_64
        medium_ram
        medium_ram_64
        medium_cpu
        medium_cpu_64
        large
        xlarge
        xlarge_cpu
        xlarge_ram
        doublexlarge_ram
        quadxlarge_ram
        quadxlarge_io
      )

      # Create an Instance representation
      #
      # @param attrs [Hash]
      def initialize(attrs)
        attrs.each do |(attr, value)|
          send("#{attr}=", value)
        end
      end
    end
  end
end
