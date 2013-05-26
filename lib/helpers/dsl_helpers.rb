module RMonitor
  module DSLHelpers
    class Profile
      attr_accessor :profiles

      def initialize
        @profiles = []
      end

      def profile(name, options = {}, &block)
        device_parser = Device.new
        device_parser.instance_eval(&block)

        @profiles << { :name => name,
                       :options => options,
                       :devices => device_parser.devices }
      end
    end

    class Device
      attr_accessor :devices

      def initialize
        @devices = []
      end

      def device(name, options = {})
        @devices << { :name => name }.merge(options)
      end
    end
  end
end
