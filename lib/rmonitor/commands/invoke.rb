class RMonitor
  module Commands
    class Invoke
      def initialize(options = {})
        @profiles = options[:profiles] || Config.new.profiles
        @matcher = options[:matcher] || Matcher.new(options)
        @strategy = options[:strategy] || Strategies::Pessimistic.new(options)
        @factory = options[:factory] || Actions.new(options)
      end

      def execute(name)
        profile = @profiles.find { |p| p[:name] == name }

        raise UnknownProfileError unless profile
        raise UninvokableProfileError unless @matcher.invokable?(profile)

        actions = @factory.create(profile)

        @strategy.execute(actions)
      end
    end
  end
end
