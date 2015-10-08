class RMonitor
  module Profile
    class DSL
      attr_accessor :devices

      def initialize
        @devices = []
      end

      def device(name, options = {})
        @devices << options.merge(:name => name)
      end
    end
  end
end
