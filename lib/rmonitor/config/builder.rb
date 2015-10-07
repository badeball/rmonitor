require "rmonitor/config/dsl"

class RMonitor
  class Config
    class Builder
      class << self
        def define(input = nil, &block)
          dsl = RMonitor::Config::DSL.new

          if input
            dsl.instance_eval(input)
          else
            dsl.instance_eval(&block)
          end

          dsl.profiles
        end
      end
    end
  end
end
