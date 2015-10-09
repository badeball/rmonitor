class RMonitor
  class Matcher
    def initialize(options = {})
      @capabilities = options[:capabilities] || Capabilities.new(options).parse
    end

    def invokable?(profile)
      return false if profile.has_key?(:only_if) && !profile[:only_if].call
      return false if profile.has_key?(:not_if) && profile[:not_if].call

      profile[:devices].all? do |device|
        has_desired_capability? device
      end
    end

    private

    def has_desired_capability?(desire)
      @capabilities.any? do |capability|
        match_desire_capability?(desire, capability)
      end
    end

    def match_desire_capability?(desire, capability)
      return false if desire[:name] != capability[:name]
      return false if desire[:mode] && desire[:mode] != capability[:mode]
      return false if desire[:rate] && desire[:rate] != capability[:rate]

      true
    end
  end
end
