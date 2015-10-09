require "rmonitor/strategies/base"

class RMonitor
  module Strategies
    class Pessimistic < Base
      def execute(actions)
        transformations = actions.map do |action|
          @transformer.transform(action)
        end

        transformations.each do |transformation|
          @xrandr.invoke(*transformation)
        end
      end
    end
  end
end
