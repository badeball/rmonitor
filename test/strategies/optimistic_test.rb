require "test_helper"

describe RMonitor::Strategies::Optimistic do

  describe "#execute" do

    it "should invoke actions as a single system call" do
      invoker = MiniTest::Mock.new
      invoker.expect :invoke, nil, ["xrandr --output LVDS1 --off --output HDMI1 --output HDMI2"]

      actions = RMonitor::Actions::Builder.define do
        off "LVDS1"
        on "HDMI1"
        on "HDMI2"
      end

      RMonitor::Strategies::Optimistic.new(:invoker => invoker).execute(actions)

      invoker.verify
    end

  end

end
