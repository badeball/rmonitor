require "test_helper"
require "fakefs/safe"

describe RMonitor::Commands::List do

  before :each do
    FakeFS.activate!

    RMonitor::Config.config_path = nil

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
  end

  after :each do
    FakeFS.deactivate!
  end

  describe "#execute" do

    it "should return a list of all profiles" do
      expected = RMonitor::Config::Builder.define do
        profile "docked" do
          device "HDMI1", :mode => "1920x1080", :rate => "60.0"
          device "HDMI2", :mode => "1920x1080", :rate => "60.0"
        end

        profile "default" do
          device "eDP1", :mode => "1920x1080"
        end
      end

      actual = RMonitor::Commands::List.new.execute

      assert_equal expected, actual
    end

  end

end
