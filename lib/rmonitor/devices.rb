require 'rmonitor/helpers/xrandr_read_helpers'

class RMonitor
  class Devices
    extend XRandRReadHelpers

    def self.parse(devices_data)
      # Split the blocks of XRandR output
      blocks  = split_blocks(devices_data)

      # Filter out blocks that are not devices
      devices = collect_devices(blocks)

      # Create a data structure for each block
      devices.map! do |device|
        {
            :name           => extract_name(device),
            :pos            => extract_pos(device),
            :connected      => extract_connected(device),
            :enabled        => extract_enabled(device),
            :configuration  => extract_configuration(device),
            :configurations => extract_configurations(device),
        }
      end

      devices
    end
  end
end
