require "rmonitor"
require "minitest/autorun"
require "minitest/reporters"

DEFAULT_CONFIG_PATH = File.expand_path "~/.config/rmonitor/config.rb"

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

module Minitest::Assertions
  def assert_subset_of(collection, subset)
    subset.each do |element|
      assert_includes collection, element
    end
  end
end
