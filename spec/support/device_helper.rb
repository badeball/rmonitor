def parse_device(device_data)
  RMonitor::Devices.parse(device_data).first
end
