module RMonitor
  module Profile
    def self.invokable?(profile)
      profile[:devices].all? do |device|
        DEVICES.has_key?(device[:name]) and
        !first_matching_configuration(DEVICES[device[:name]],
                                      device[:mode],
                                      device[:rate]).nil?
      end
    end

    def self.to_xrandr(profile)
      xrandr = 'xrandr'

      off = (DEVICES.keys - profile[:devices].map { |d| d[:name] })

      unless off.empty?
        off.each do |name|
          xrandr << ' --output %{name} --off' % { :name => name }
        end

        xrandr << ' && xrandr'
      end

      profile[:devices].each do |device|
        configuration = first_matching_configuration(DEVICES[device[:name]],
                                                     device[:mode],
                                                     device[:rate])

        xrandr << ' --output %s --mode %s --rate %s' % [
            device[:name],
            configuration[:mode],
            configuration[:rate],
        ]

        if device[:pos]
          xrandr << " --pos #{device[:pos]}"
        elsif device[:left_of]
          xrandr << " --left-of #{device[:left_of]}"
        elsif device[:right_of]
          xrandr << " --right-of #{device[:right_of]}"
        elsif device[:above]
          xrandr << " --above #{device[:above]}"
        elsif device[:below]
          xrandr << " --below #{device[:below]}"
        end
      end

      xrandr
    end

    private

    def self.first_matching_configuration(device, mode, rate)
      device[:configurations].find do |configuration|
        !mode or configuration[:mode] == mode &&
        !rate or configuration[:rate] == rate
      end
    end
  end
end
