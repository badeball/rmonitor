require "test_helper"
require "fakefs/safe"

describe RMonitor::Commands::Update do

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

    it "should throw an exception when no profiles are invokable" do
      invoker = MiniTest::Mock.new

      invoker.expect :invoke, <<-XRANDR, ["xrandr"]
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        LVDS1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
      XRANDR

      cache = RMonitor::Cache.new(:invoker => invoker)

      assert_raises RMonitor::NoInvokableProfileError do
        RMonitor::Commands::Update.new(:invoker => cache).execute
      end
    end

    it "should invoke the first invokable profile when one exist" do
      invoker = MiniTest::Mock.new

      invoker.expect :invoke, <<-XRANDR, ["xrandr"]
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        eDP1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
      XRANDR

      invoker.expect :invoke, nil, ["xrandr --output eDP1 --mode 1920x1080"]

      cache = RMonitor::Cache.new(:invoker => invoker)

      RMonitor::Commands::Update.new(:invoker => cache).execute

      invoker.verify
    end

  end

end
