require "test_helper"
require "stringio"

describe RMonitor::Commands::CL::List do

  describe "#execute" do

    it "should output profiles in a human readable manner" do
      profiles = RMonitor::Config::Builder.define do
        profile "docked" do
          device "HDMI1", :mode => "1920x1080", :rate => "60.0"
          device "HDMI2", :mode => "1920x1080", :rate => "60.0"
        end

        profile "default" do
          device "eDP1", :mode => "1920x1080"
        end
      end

      matcher = MiniTest::Mock.new
      matcher.expect :invokable?, true, [profiles.first]
      matcher.expect :invokable?, false, [profiles.last]

      out = StringIO.new

      RMonitor::Commands::CL::List.new(:profiles => profiles, :matcher => matcher, :out => out).execute

      assert_equal <<-LIST, out.string
docked\tinvokable\tHDMI1 (1920x1080 60.0)\tHDMI2 (1920x1080 60.0)
default\tuninvokable\teDP1 (1920x1080)
      LIST
    end

  end

end
