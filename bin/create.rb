#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

rm = RMonitor::RMonitor.load

puts "profile #{($options[:name] || 'My profile').inspect} do"
  rm.devices.each do |device|
    if device[:enabled]
      puts '  device %s, :mode => %s, :rate => %s, :pos => %s' % [
          device[:name].inspect,
          device[:configuration][:mode].inspect,
          device[:configuration][:rate].inspect,
          device[:pos].inspect,
      ]
    end
  end
puts 'end'
