require "rmonitor"
require "minitest/autorun"
require "minitest/reporters"

DEFAULT_CONFIG_PATH = File.expand_path "~/.config/rmonitor/config.rb"

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new
