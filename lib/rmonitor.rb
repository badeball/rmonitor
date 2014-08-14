require 'fileutils'

require 'rmonitor/devices'
require 'rmonitor/profiles'

class RMonitor
  class XRandRArgumentError < ArgumentError; end

  CONFIG_PATH = File.join(Dir.home, '.config', 'rmonitor', 'config.rb')

  # Create a config directory and config file if they don't exist
  begin
    config_directory = File.dirname(CONFIG_PATH)
    Dir::mkdir(config_directory) unless Dir.exists?(config_directory)
    FileUtils.touch(CONFIG_PATH) unless File.exists?(CONFIG_PATH)
  end

  attr_accessor :devices, :profiles

  def initialize(raw_devices_data, raw_profiles_data)
    @devices  = Devices.parse(raw_devices_data)
    @profiles = Profiles.parse(raw_profiles_data)
  end

  def self.load
    self.new(`xrandr -q`, File.new(CONFIG_PATH).read)
  end
end
