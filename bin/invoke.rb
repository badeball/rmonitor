#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

rm = RMonitor::RMonitor.load

profile = rm.profiles.find { |p| p[:name] == $options[:name] }

if profile
  if RMonitor::Profiles.invokable?(rm.devices, profile)
    exec(RMonitor::Profiles.to_xrandr(rm.devices, profile))
  else
    puts 'error: this profile is not invokable'
  end
else
  puts 'notice: no profile with that name exists'
end
