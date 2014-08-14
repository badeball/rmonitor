#!/usr/bin/env ruby

require 'optparse'

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'rmonitor.rb'))

options = { :action => :create }

OptionParser.new do |opts|
  opts.banner = "Usage: rmonitor [option]"

  opts.on("-c", "--create [NAME]", String, "Create and output a profile with an optional name") do |name|
    options[:action] = :create
    options[:name] = name
  end

  opts.on("-i", "--invoke NAME", String, "Invoke a profile with a given name") do |name|
    options[:action] = :invoke
    options[:name] = name
  end

  opts.on("-u", "--update", "Invoke the most preferable profile") do
    options[:action] = :update
  end

  opts.on("-v", "--verbose", "Verbose output") do
    options[:verbose] = true
  end

  opts.on("-d", "--dry-run", "Do everything except actually update") do
    options[:dry_run] = true
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end
end.parse!

rm = RMonitor::RMonitor.load

if options[:action] == :update
  # Find the first invokable profile
  profile = rm.profiles.find do |profile|
    RMonitor::Profiles.invokable?(rm.devices, profile)
  end

  if profile
    puts "Found #{profile[:name].inspect} that is invokable." if options[:verbose]
    options[:name] = profile[:name]
    options[:action] = :invoke
  else
    exit_with 'notice: no invokable profile exists'
  end
end

if options[:action] == :invoke
  profile = rm.profiles.find { |p| p[:name] == options[:name] }

  if profile
    if RMonitor::Profiles.invokable?(rm.devices, profile)
      command = RMonitor::Profiles.to_xrandr(rm.devices, profile)
      puts "Invoking #{profile[:name].inspect} by running #{command.inspect}." if options[:verbose]
      exec(command) unless options[:dry_run]
    else
      puts 'error: this profile is not invokable'
    end
  else
    puts 'notice: no profile with that name exists'
  end

elsif options[:action] == :create
  puts "profile #{(options[:name] || 'My profile').inspect} do"
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
end
