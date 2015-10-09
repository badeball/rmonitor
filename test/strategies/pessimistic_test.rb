require "test_helper"

describe RMonitor::Strategies::Optimistic do

  describe "#execute" do

    it "should invoke actions as multiple system call" do
      invoker = MiniTest::Mock.new
      invoker.expect :invoke, nil, ["xrandr --output LVDS1 --off"]
      invoker.expect :invoke, nil, ["xrandr --output HDMI1"]
      invoker.expect :invoke, nil, ["xrandr --output HDMI2"]

      actions = RMonitor::Actions::Builder.define do
        off "LVDS1"
        on "HDMI1"
        on "HDMI2"
      end

      RMonitor::Strategies::Pessimistic.new(:invoker => invoker).execute(actions)

      invoker.verify
    end

  end

end
