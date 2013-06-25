#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

rm = RMonitor::RMonitor.load

# Find the first invokable profile
profile = rm.profiles.find do |profile|
  RMonitor::Profiles.invokable?(rm.devices, profile)
end

if profile
  puts "Found #{profile[:name].inspect} that is invokable." if $options[:verbose]
  $options[:name] = profile[:name]
  require File.join(File.dirname(__FILE__), 'invoke')
else
  puts 'notice: no invokable profile exists'
end
