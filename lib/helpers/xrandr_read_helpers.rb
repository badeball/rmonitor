module RMonitor
  module XRandRReadHelpers
    def split_blocks(devices_data)
      block = /
        ^[^\s] .+? \n (?=[^\s]|\Z)
      /mx

      devices_data.scan(block)
    end

    def collect_devices(blocks)
      blocks.reject do |block|
        block.match(/\AScreen/)
      end
    end

    def extract_name(block)
      block.split.first
    end

    def extract_pos(block)
      if /\+(?<x_pos>\d+)\+(?<y_pos>\d+)/ =~ block
        "#{x_pos}x#{y_pos}"
      end
    end

    def extract_enabled(block)
      block.match(/\d+x\d+\+\d+\+\d+/)
    end

    def extract_connected(block)
      block.match(/(?<!dis)connected/)
    end

    def extract_configuration(block)
      # Consider each line except the first
      block.split("\n")[1..-1].each do |configuration_line|

        # See if it contains any current configurations
        if /(?<rate>\d+\.\d)\*/ =~ configuration_line

          # Extract the mode (resolution)
          /(?<mode>\d+x\d+)/ =~ configuration_line
          return {
              :mode => mode,
              :rate => rate,
          }
        end
      end

      nil
    end

    def extract_configurations(block)
      configurations = []

      # Consider each line except the first
      block.split("\n")[1..-1].each do |configuration_block|

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
