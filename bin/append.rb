#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

create = IO.popen(['rmonitor', '--create', ARGV.first].compact, :err => [:child, :out])

Process.wait(create.pid)

if $?.success?
  File.open(RMonitor::CONFIG_PATH, 'a') do |f|
    f.write(create.readlines.join)
  end
else
  puts create.readlines
  puts 'error: rmonitor-create exited with a non-zero exit status'
end
