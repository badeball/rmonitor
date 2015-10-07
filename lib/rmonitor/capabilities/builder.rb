require "rmonitor/capabilities/dsl"

class RMonitor
  class Capabilities
    class Builder
      class << self
        def define(&block)
          dsl = RMonitor::Capabilities::DSL.new
          dsl.instance_eval(&block)
          dsl.capabilities
        end
      end
    end
  end
end
