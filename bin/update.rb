#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

# Find the first invokable profile
profile = RMonitor::PROFILES.find do |profile|
  RMonitor::Profile.invokable?(profile)
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
