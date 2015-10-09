class RMonitor
  class Cache
    def initialize(options = {})
      @output = {}
      @invoker = options[:invoker] || Invoker.new(options)
    end

    def invoke(command)
      @output[command] ||= @invoker.invoke(command)
    end
  end
end
