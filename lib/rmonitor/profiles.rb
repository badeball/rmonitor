require 'rmonitor/helpers/dsl_helpers'
require 'rmonitor/helpers/profile_helpers'
require 'rmonitor/helpers/xrandr_write_helpers'

class RMonitor
  class Profiles
    include DSLHelpers
    extend ProfileHelpers
    extend XRandRWriteHelpers

    def self.parse(config_data)
      profile_builder = ProfileBuilder.new
      profile_builder.instance_eval(config_data)
      profile_builder.profiles
    end

    def self.to_xrandr(devices, profile)
      xrandr = 'xrandr'

      # Devices that are currently enabled, but not contained in the profile
      to_disable = devices.select { |d| d[:enabled ]}.map { |d| d[:name] } -
          profile[:devices].map { |d| d[:name] }

      unless to_disable.empty?
        to_disable.each do |name|
          xrandr << ' ' << turn_off(name)
        end

        xrandr << ' && xrandr'
      end

      if profile[:options] and profile[:options][:dpi]
        xrandr << ' --dpi ' << profile[:options][:dpi].to_s
      end

      # The devices contained in the profile are to be turned on and configured
      profile[:devices].each do |wanted_device|
        device = devices.find { |d| d[:name] == wanted_device[:name] }

        configuration = best_matching_configuration(device,
                                                    wanted_device[:mode],
                                                    wanted_device[:rate])

        xrandr << ' ' << turn_on(device[:name],
                                 configuration.merge(wanted_device))
      end

      xrandr
    end
  end
end
