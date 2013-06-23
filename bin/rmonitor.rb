#!/usr/bin/env ruby

require 'optparse'
require 'shellwords'

$options = { :action => :create }

OptionParser.new do |opts|
  opts.banner = "Usage: rmonitor [option]"

  opts.on("--append [NAME]", String, "Create a profile with an optional name and append it to the config (~/.config/rmonitor/config.rb)") do |name|
    $options[:action] = :append
    $options[:name] = name
  end

  opts.on("--create [NAME]", String, "Create and output a profile with an optional name") do |name|
    $options[:action] = :create
    $options[:name] = name
  end

  opts.on("--invoke NAME", String, "Invoke a profile with a given name") do |name|
    $options[:action] = :invoke
    $options[:name] = name
  end

  opts.on("--update", "Invoke the most preferable profile") do
    $options[:action] = :update
  end

  opts.on("-v", "--verbose", "Verbose output") do
    $options[:verbose] = true
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
