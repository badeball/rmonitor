#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

profile = RMonitor::PROFILES.find { |p| p[:name] == ARGV.first }

if profile
  if RMonitor::Profile.invokable?(profile)
    exec(RMonitor::Profile.to_xrandr(profile))
  else
    puts 'error: this profile is not invokable'
  end
else
  puts 'notice: no profile with that name exists'
end
