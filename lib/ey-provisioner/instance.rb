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
        medium_ram
        medium_cpu
        c3_large
        large
        c3_xlarge
        xlarge_ram
        xlarge
        xlarge_cpu
        c3_2xlarge
        doublexlarge_ram
        c3_4xlarge
        quadxlarge_ram
        c3_8xlarge
        quadxlarge_io
        m3_medium
        m3_large
        m3_xlarge
        m3_2xlarge
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
