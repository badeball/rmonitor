#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

rm = RMonitor::RMonitor.load

# Find the first invokable profile
profile = rm.profiles.find do |profile|
  RMonitor::Profiles.invokable?(rm.devices, profile)
end

if profile
  invoke = IO.popen(['rmonitor', '--invoke', profile[:name]], :err => [:child, :out])

  Process.wait(invoke.pid)

  unless $?.success?
    puts invoke.readlines
    puts 'error: rmonitor-invoke exited with a non-zero exit status'
  end
else
  puts 'notice: no invokable profile exists'
end
