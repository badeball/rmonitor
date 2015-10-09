class RMonitor
  module Commands
    class List
      def initialize(options = {})
        @profiles = options[:profiles] || Config.new.profiles
      end

      def execute
        @profiles
      end
    end
  end
end
