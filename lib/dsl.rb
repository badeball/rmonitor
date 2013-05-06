module RMonitor
  module DSL
    class DSLProfile
      attr_accessor :profiles

      def initialize
        @profiles = {}
      end

      def profile(name, &block)
        device_parser = DSLDevice.new
        device_parser.instance_eval(&block)

        @profiles[name] = device_parser.devices
      end
    end

    class DSLDevice
      attr_accessor :devices

      def initialize
        @devices = []
      end

      def device(name, options = {})
        @devices << { :name => name }.merge(options)
      end
    end

    def self.parse(config_file_path)
      profile_parser = DSLProfile.new
      profile_parser.instance_eval(File.new(config_file_path).read)
      profile_parser.profiles
    end
  end
end
