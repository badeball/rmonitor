#!/usr/bin/env ruby

require 'stringio'

require File.join(File.dirname(__FILE__), '..', 'rmonitor')

configuration = StringIO.new
$stdout = configuration

begin
  require File.join(File.dirname(__FILE__), 'create.rb')

  if $options[:verbose]
    puts "Writing configuration to #{RMonitor::CONFIG_PATH}."
    puts ""
    puts configuration.string
  end

  File.open(RMonitor::CONFIG_PATH, 'a') do |f|
    f.write(configuration.string)
  end

  $stdout = STDOUT
rescue Exception
  $stdout = STDOUT
  puts configuration.string
  puts 'error: rmonitor-create exited with a non-zero exit status'
end
