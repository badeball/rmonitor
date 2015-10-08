class RMonitor
  class Selector
    def initialize(options = {})
      @profiles = options[:profiles] || Config.new.profiles
      @matcher = options[:matcher] || Matcher.new(options)
    end

    def first_invokable
      @profiles.find do |profile|
        @matcher.invokable? profile
      end
    end
  end
end
