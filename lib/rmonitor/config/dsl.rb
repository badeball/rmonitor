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

        if @profiles.last.has_key?(:only_if)
          @profiles.last[:only_if] = method(@profiles.last[:only_if])
        end

        if @profiles.last.has_key?(:not_if)
          @profiles.last[:not_if] = method(@profiles.last[:not_if])
        end
      end
    end
  end
end
