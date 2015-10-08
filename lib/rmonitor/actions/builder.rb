require "rmonitor/actions/dsl"

class RMonitor
  class Actions
    class Builder
      class << self
        def define(&block)
          dsl = RMonitor::Actions::DSL.new
          dsl.instance_eval(&block)
          dsl.actions
        end
      end
    end
  end
end
