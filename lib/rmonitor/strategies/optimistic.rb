require "rmonitor/strategies/base"

class RMonitor
  module Strategies
    class Optimistic < Base
      def execute(actions)
        transformations = actions.map do |action|
          @transformer.transform(action)
        end

        @xrandr.invoke(*transformations.flatten)
      end
    end
  end
end
