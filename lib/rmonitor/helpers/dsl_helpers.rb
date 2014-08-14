class RMonitor
  module DSLHelpers
    class ProfileBuilder
      attr_accessor :profiles

      def initialize
        @profiles = []
      end

      def profile(name, options = {}, &block)
        device_builder = DeviceBuilder.new
        device_builder.instance_eval(&block)

        if options[:only_if]
          options[:only_if] = method(options[:only_if])
        elsif options[:not_if]
          options[:not_if] = method(options[:not_if])
        end

        @profiles << { :name => name,
                       :options => options,
                       :devices => device_builder.devices }
      end
    end

    class DeviceBuilder
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
