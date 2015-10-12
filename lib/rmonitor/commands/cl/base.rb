class RMonitor
  module Commands
    module CL
      class Base
        def initialize(options = {})
          @options = options
          @out = options[:out] || $stdout
          @err = options[:err] || $stderr
        end
      end
    end
  end
end
