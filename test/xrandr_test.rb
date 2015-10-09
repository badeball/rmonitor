require "test_helper"
require "stringio"

describe RMonitor::XRandR do

  describe "#invoke" do

    describe "when :dry_run is false" do

      it "should call the system invoker with xrandr and the argument concatenation" do
        invoker = MiniTest::Mock.new
        invoker.expect :invoke, nil, ["xrandr --output HDMI1 --auto"]

        RMonitor::XRandR.new(:invoker => invoker, :dry_run => false).invoke("--output", "HDMI1", "--auto")

        invoker.verify
      end

    end

    describe "when :dry_run is true and given no arguments" do

      it "should call the system invoker with xrandr" do
        invoker = MiniTest::Mock.new
        invoker.expect :invoke, nil, ["xrandr"]

        RMonitor::XRandR.new(:invoker => invoker, :dry_run => true).invoke

        invoker.verify
      end

    end

    describe "when :dry_run is true and given ssome arguments" do

      it "should not call the system invoker" do
        invoker = MiniTest::Mock.new # No expectations

        RMonitor::XRandR.new(:invoker => invoker, :dry_run => true).invoke("--output", "HDMI1", "--auto")

        invoker.verify
      end

    end

    describe "when :verbose is false" do

      it "should not output anything" do
        out = StringIO.new
        invoker = MiniTest::Mock.new
        invoker.expect :invoke, nil, ["xrandr --output HDMI1 --auto"]

        RMonitor::XRandR.new(:invoker => invoker, :verbose => false, :out => out).invoke("--output", "HDMI1", "--auto")

        assert_equal "", out.string
      end

    end

    describe "when :verbose is true" do

      it "should output the command" do
        out = StringIO.new
        invoker = MiniTest::Mock.new
        invoker.expect :invoke, nil, ["xrandr --output HDMI1 --auto"]

        RMonitor::XRandR.new(:invoker => invoker, :verbose => true, :out => out).invoke("--output", "HDMI1", "--auto")

        assert_equal "xrandr --output HDMI1 --auto\n", out.string
      end

    end

  end

end
