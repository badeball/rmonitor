require "rmonitor/commands/invoke"

class RMonitor
  module Commands
    module CL
      class Invoke
        def initialize(options = {})
          @err = options[:err] || $stderr
          @invoke = options[:invoke] || RMonitor::Commands::Invoke.new(options)
        end

        def execute(name)
          @invoke.execute(name)
        rescue RMonitor::UnknownProfileError
          @err.puts "unknown profile"
        rescue RMonitor::UninvokableProfileError
          @err.puts "profile is not invokable"
        end
      end
    end
  end
end
