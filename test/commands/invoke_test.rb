require "test_helper"
require "fakefs/safe"

describe RMonitor::Commands::Invoke do

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

    it "should throw an exception when given an unknown profile name" do
      invoker = MiniTest::Mock.new

      invoker.expect :invoke, <<-XRANDR, ["xrandr"]
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
      XRANDR

      cache = RMonitor::Cache.new(:invoker => invoker)

      assert_raises RMonitor::UnknownProfileError do
        RMonitor::Commands::Invoke.new(:invoker => cache).execute("foo")
      end
    end

    it "should throw an exception if a profile is not invokable" do
      invoker = MiniTest::Mock.new

      invoker.expect :invoke, <<-XRANDR, ["xrandr"]
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
      XRANDR

      cache = RMonitor::Cache.new(:invoker => invoker)

      assert_raises RMonitor::UninvokableProfileError do
        RMonitor::Commands::Invoke.new(:invoker => cache).execute("docked")
      end
    end

    it "should call xrandr on the system when given an existing profile name" do
      invoker = MiniTest::Mock.new

      invoker.expect :invoke, <<-XRANDR, ["xrandr"]
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
        HDMI2 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
      XRANDR

      invoker.expect :invoke, nil, ["xrandr --output HDMI1 --mode 1920x1080 --rate 60.0"]
      invoker.expect :invoke, nil, ["xrandr --output HDMI2 --mode 1920x1080 --rate 60.0"]

      cache = RMonitor::Cache.new(:invoker => invoker)

      RMonitor::Commands::Invoke.new(:invoker => cache).execute("docked")

      invoker.verify
    end

  end

end
