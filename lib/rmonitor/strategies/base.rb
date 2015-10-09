class RMonitor
  module Strategies
    class Base
      def initialize(options = {})
        @xrandr = options[:xrandr] || XRandR.new(options)
        @transformer = options[:transformer] || Transformer.new
      end
    end
  end
end
