module RMonitor
  module XRandR
    def self.parse(t)
      block = /
        ^[^\s] .+? (?=^[^\s]|\Z)
      /mx

      # Split the output of XRandR into blocks containing information about each device
      devices = t.scan(block)

      # Remove screen-i blocks
      devices.reject! do |device|
        device.match(/\AScreen/)
      end

      # Remove disconnected devices
      devices.reject! do |device|
        device.match(/disconnected/)
      end

      # Create a data structure from the remaining blocks
      devices.map! do |device|
        [ device.split.first,
          { :pos => pos(device),
            :configuration => configuration(device),
            :configurations => configurations(device) } ]
      end

      Hash[devices]
    end

    private

    def self.pos(device)
      if /\+(?<x_pos>\d+)\+(?<y_pos>\d+)/ =~ device.split("\n").first
        "#{x_pos}x#{y_pos}"
      end
    end

    def self.configuration(device)
      # Consider each line except the first
      device.split("\n")[1..-1].each do |configuration_block|

        # See if it contains any current configurations
        if /(?<rate>\d+\.\d)\*/ =~ configuration_block

          # Extract the mode (resolution)
          /(?<mode>\d+x\d+)/ =~ configuration_block
          return {
              :mode => mode,
              :rate => rate,
          }
        end
      end

      nil
    end

    def self.configurations(device)
      configurations = []

      # Consider each line except the first
      device.split("\n")[1..-1].each do |configuration_block|

        # Extract the mode (resolution)
        /(?<mode>\d+x\d+)/ =~ configuration_block

        # Extract each supported frame rate of that mode (resolution)
        configuration_block.scan(/\d+\.\d/).each do |rate|
          configurations <<  {
              :mode => mode,
              :rate => rate,
          }
        end
      end

      configurations
    end
  end
end
