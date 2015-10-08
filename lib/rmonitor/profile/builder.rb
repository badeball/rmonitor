require "rmonitor/profile/dsl"

class RMonitor
  module Profile
    class Builder
      class << self
        def define(name, options = {}, &block)
          dsl = RMonitor::Profile::DSL.new
          dsl.instance_eval &block
          options.merge :name => name, :devices => dsl.devices
        end
      end
    end
  end
end
