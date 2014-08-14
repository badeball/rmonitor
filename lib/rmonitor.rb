require 'fileutils'

require 'rmonitor/devices'
require 'rmonitor/profiles'

class RMonitor
  class XRandRArgumentError < ArgumentError; end

  class << self
    attr_accessor :config_path
  end

  attr_accessor :devices, :profiles

  def initialize(raw_devices_data, raw_profiles_data)
    @devices  = Devices.parse(raw_devices_data)
    @profiles = Profiles.parse(raw_profiles_data)
  end

  def self.load
    self.new(`xrandr -q`, File.new(config_path).read)
  end
end
