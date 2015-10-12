require "rmonitor/capabilities/builder"

class RMonitor
  class Capabilities
    def initialize(options = {})
      @xrandr = options[:xrandr] || XRandR.new(options)
    end

    def parse(input = @xrandr.invoke)
      capabilities = []
      current_name = nil

      input = input.split("\n").tap(&:shift).map(&:strip)

      input.each do |line|
        if /(?<name>\w+) (dis)?connected/ =~ line
          current_name = name
        end

        if /(?<mode>\d+x\d+)/ =~ line
          line.scan(/\s(\d+(?:\.\d+)?)(?:( |\*)( |\+)?)?/) do |rate, native, current|
            capabilities << {:name => current_name, :mode => mode, :rate => rate}

            if native == "*"
              capabilities.last[:native] = true
            end

            if current == "+"
              capabilities.last[:current] = true
            end
          end
        end
      end

      capabilities
    end
  end
end
