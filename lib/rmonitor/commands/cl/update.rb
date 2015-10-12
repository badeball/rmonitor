require "rmonitor/commands/update"

class RMonitor
  module Commands
    module CL
      class Update
        def initialize(options = {})
          @err = options[:err] || $stderr
          @update = options[:update] || RMonitor::Commands::Update.new(options)
        end

        def execute
          @update.execute
        rescue RMonitor::NoInvokableProfileError
          @err.puts "no invokable profile"
        end
      end
    end
  end
end
