#!/usr/bin/env ruby

require 'optparse'
require 'shellwords'

$options = { :action => :create }

OptionParser.new do |opts|
  opts.banner = "Usage: rmonitor [option]"

  opts.on("-c", "--create [NAME]", String, "Create and output a profile with an optional name") do |name|
    $options[:action] = :create
    $options[:name] = name
  end

  opts.on("-i", "--invoke NAME", String, "Invoke a profile with a given name") do |name|
    $options[:action] = :invoke
    $options[:name] = name
  end

  opts.on("-u", "--update", "Invoke the most preferable profile") do
    $options[:action] = :update
  end

  opts.on("-v", "--verbose", "Verbose output") do
    $options[:verbose] = true
  end

  opts.on("-d", "--dry-run", "Do everything except actually update") do
    $options[:dry_run] = true
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end
end.parse!

file = if File.symlink?(__FILE__)
         File.readlink(__FILE__)
       else
         File.expand_path(__FILE__)
       end

require File.join(File.dirname(file), $options[:action].to_s)
