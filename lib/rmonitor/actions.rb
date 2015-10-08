require "rmonitor/actions/builder"

class RMonitor
  class Actions
    def initialize(options = {})
      @capabilities = options[:capabilities] || Capabilities.new(options).parse
    end

    def create(profile)
      actions = []

      @avaialble_devices = @capabilities.map { |capability| capability[:name] }.uniq
      @desired_devices = profile[:devices].map { |device| device[:name] }

      (@avaialble_devices - @desired_devices).each do |device|
        actions << {:action => :off, :name => device}
      end

      profile[:devices].each do |device|
        actions << device.merge(:action => :on)
      end

      actions
    end
  end
end
