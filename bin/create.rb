#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

puts "profile #{(ARGV.first || 'My profile').inspect} do"
  RMonitor::DEVICES.each do |name, device|
    if device[:configuration]
      puts '  device %s, :mode => %s, :rate => %s, :pos => %s' % [
          name.inspect,
          device[:configuration][:mode].inspect,
          device[:configuration][:rate].inspect,
          device[:pos].inspect,
      ]
    end
  end
puts 'end'
