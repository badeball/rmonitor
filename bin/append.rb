#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

create = IO.popen(['rmonitor', '--create', ARGV.first].compact, :err => [:child, :out])

Process.wait(create.pid)

if $?.success?
  config_directory = File.dirname(RMonitor::CONFIG_PATH)
  Dir::mkdir(config_directory) unless Dir.exists?(config_directory)

  File.open(File.join(config_directory, 'config.rb'), 'a') do |f|
    f.write(create.readlines.join)
  end
else
  puts create.readlines
  puts 'error: rmonitor-create exited with a non-zero exit status'
end
