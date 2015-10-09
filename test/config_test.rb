require "test_helper"
require "fakefs/safe"
require "fileutils"

describe RMonitor::Config do

  before :each do
    FakeFS.activate!

    RMonitor::Config.config_path = nil
  end

  after :each do
    FakeFS.deactivate!
  end

  describe "#read" do

    it "should by default return the content of #{DEFAULT_CONFIG_PATH}" do
      FileUtils.mkdir_p File.dirname DEFAULT_CONFIG_PATH
      File.write DEFAULT_CONFIG_PATH, "foo"

      assert_equal "foo", RMonitor::Config.new.read
    end

    it "should supported reading from arbritary locations as well" do
      RMonitor::Config.config_path = "/config.rb"
      File.write "/config.rb", "foo"

      assert_equal "foo", RMonitor::Config.new.read
    end

  end

  describe "#profiles" do

    it "should build and return the profiles contained in the config" do
      FileUtils.mkdir_p File.dirname DEFAULT_CONFIG_PATH
      File.write DEFAULT_CONFIG_PATH, <<-CONFIG
        profile "docked" do
          device "HDMI1", :mode => "1920x1080", :rate => "60.0"
          device "HDMI2", :mode => "1920x1080", :rate => "60.0"
        end

        profile "default" do
          device "eDP1", :mode => "1920x1080"
        end
      CONFIG

      expected = RMonitor::Config::Builder.define do
        profile "docked" do
          device "HDMI1", :mode => "1920x1080", :rate => "60.0"
          device "HDMI2", :mode => "1920x1080", :rate => "60.0"
        end

        profile "default" do
          device "eDP1", :mode => "1920x1080"
        end
      end

      actual = RMonitor::Config.new.profiles

      assert_equal expected, actual
    end

  end

end
