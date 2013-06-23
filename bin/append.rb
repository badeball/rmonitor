#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

create = IO.popen([File.join(File.dirname(__FILE__), 'rmonitor.rb'),
                   '--create',
                   $options[:name]].compact,
                  :err => [:child, :out])

Process.wait(create.pid)

if $?.success?
  configuration = create.readlines.join

  if $options[:verbose]
    puts "Writing configuration to #{RMonitor::CONFIG_PATH}."
    puts ""
    puts configuration
  end

  File.open(RMonitor::CONFIG_PATH, 'a') do |f|
    f.write(configuration)
  end
else
  puts create.readlines
  puts 'error: rmonitor-create exited with a non-zero exit status'
end
