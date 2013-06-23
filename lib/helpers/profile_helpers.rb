module RMonitor
  module ProfileHelpers
    def invokable?(devices, profile)
      necessary_devices_present?(devices, profile) && user_defined_rules_satisfied?(profile)
    end

    def necessary_devices_present?(devices, profile)
      profile[:devices].all? do |wanted_device|
        device = devices.find { |d| d[:name] == wanted_device[:name] }

        device and
            has_matching_configuration(device,
                                       wanted_device[:mode],
                                       wanted_device[:rate])
      end
    end

    def user_defined_rules_satisfied?(profile)
      if profile[:options][:only_if]
        profile[:options][:only_if].call
      elsif profile[:options][:not_if]
        !profile[:options][:not_if].call
      else
        true
      end
    end

    def best_matching_configuration(device, mode, rate)
      device[:configurations].find do |configuration|
        (!mode or configuration[:mode] == mode) &&
            (!rate or configuration[:rate] == rate)
      end
    end

    def has_matching_configuration(device, mode, rate)
      !best_matching_configuration(device, mode, rate).nil?
    end
  end
end
