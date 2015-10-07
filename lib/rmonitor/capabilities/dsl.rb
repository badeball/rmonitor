class RMonitor
  class Capabilities
    class DSL
      attr_accessor :capabilities

      def initialize
        @capabilities = []
      end

      def device(name, options = {})
        @capabilities << options.merge(:name => name)
      end
    end
  end
end
