#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

profile = RMonitor::PROFILES[ARGV.first]

if profile
  exec(RMonitor::Profile.to_xrandr(profile))
else
  puts 'notice: no profile with that name exists'
end
