module RMonitor
  module ProfileHelpers
    def invokable?(devices, profile)
      profile[:devices].all? do |wanted_device|
        device = devices.find { |d| d[:name] == wanted_device[:name] }

        device and
            has_matching_configuration(device,
                                       wanted_device[:mode],
                                       wanted_device[:rate])
      end
    end

    def best_matching_configuration(device, mode, rate)
      device[:configurations].find do |configuration|
        !mode or configuration[:mode] == mode &&
            !rate or configuration[:rate] == rate
      end
    end

    def has_matching_configuration(device, mode, rate)
      !best_matching_configuration(device, mode, rate).nil?
    end
  end
end
