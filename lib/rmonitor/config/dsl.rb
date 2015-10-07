class RMonitor
  class Config
    class DSL
      attr_accessor :profiles

      def initialize
        @profiles = []
      end

      def profile(name, options = {}, &block)
        @profiles << options.merge(:name => name)
        instance_eval &block
      end

      def device(name, options = {})
        @profiles.last[:devices] ||= []
        @profiles.last[:devices] << options.merge(:name => name)
      end
    end
  end
end
