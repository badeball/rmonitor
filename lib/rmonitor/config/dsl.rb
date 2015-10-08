require "rmonitor/profile/builder"

class RMonitor
  class Config
    class DSL
      attr_accessor :profiles

      def initialize
        @profiles = []
      end

      def profile(name, options = {}, &block)
        @profiles << RMonitor::Profile::Builder.define(name, options, &block)
      end
    end
  end
end
