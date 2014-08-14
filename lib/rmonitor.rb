require 'fileutils'

require 'rmonitor/devices'
require 'rmonitor/profiles'

module RMonitor
  class XRandRArgumentError < ArgumentError; end

  CONFIG_PATH = File.join(Dir.home, '.config', 'rmonitor', 'config.rb')

  # Create a config directory and config file if they don't exist
  begin
    config_directory = File.dirname(CONFIG_PATH)
    Dir::mkdir(config_directory) unless Dir.exists?(config_directory)
    FileUtils.touch(CONFIG_PATH) unless File.exists?(CONFIG_PATH)
  end

  class RMonitor
    attr_accessor :devices, :profiles

    def initialize(devices_data, profiles_data)
      @devices  = Devices.parse(devices_data)
      @profiles = Profiles.parse(profiles_data)
    end

    def self.load
      raw_devices_data  = `xrandr -q`
      raw_profiles_data = File.new(CONFIG_PATH).read

      self.new(raw_devices_data, raw_profiles_data)
    end
  end
end
