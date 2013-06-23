#!/usr/bin/env ruby

$options ||= {}

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

rm = RMonitor::RMonitor.load

# Find the first invokable profile
profile = rm.profiles.find do |profile|
  RMonitor::Profiles.invokable?(rm.devices, profile)
end

if profile
  $options[:name] = profile[:name]
  require File.join(File.dirname(__FILE__), 'invoke')
else
  puts 'notice: no invokable profile exists'
end
