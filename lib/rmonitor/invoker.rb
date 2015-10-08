class RMonitor
  class Invoker
    def initialize(*); end

    def invoke(command)
      Kernel.`(command)
    end
  end
end
