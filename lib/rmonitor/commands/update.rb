class RMonitor
  module Commands
    class Update
      def initialize(options = {})
        @invoke = options[:invoke] || Invoke.new(options)
        @selector = options[:selector] || Selector.new(options)
      end

      def execute
        profile = @selector.first_invokable

        raise NoInvokableProfileError unless profile

        @invoke.execute(profile[:name])
      end
    end
  end
end
