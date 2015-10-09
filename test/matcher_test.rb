require "test_helper"

describe RMonitor::Matcher do

  describe "#invokable?" do

    it "should return false when the device name is lacking" do
      profile = RMonitor::Profile::Builder.define "foo" do
        device "LVDS1", :mode => "1920x1080", :rate => "60.0"
      end

      capabilities = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
        device "HDMI2", :mode => "1920x1080", :rate => "60.0"
      end

      assert_equal false, RMonitor::Matcher.new(:capabilities => capabilities).invokable?(profile)
    end

    it "should return false when the desired mode is missing" do
      profile = RMonitor::Profile::Builder.define "foo" do
        device "LVDS1", :mode => "1920x1080", :rate => "60.0"
      end

      capabilities = RMonitor::Capabilities::Builder.define do
        device "LVDS1", :mode => "820x640", :rate => "60.0"
      end

      assert_equal false, RMonitor::Matcher.new(:capabilities => capabilities).invokable?(profile)
    end

    it "should return false when the desired rate is missing" do
      profile = RMonitor::Profile::Builder.define "foo" do
        device "LVDS1", :mode => "1920x1080", :rate => "60.0"
      end

      capabilities = RMonitor::Capabilities::Builder.define do
        device "LVDS1", :mode => "1920x1080", :rate => "30.0"
      end

      assert_equal false, RMonitor::Matcher.new(:capabilities => capabilities).invokable?(profile)
    end

    it "should return false if :only_if returns false" do
      def foo
        false
      end

      profile = RMonitor::Profile::Builder.define "foo", :only_if => method(:foo) do
        device "LVDS1", :mode => "1920x1080", :rate => "60.0"
      end

      capabilities = RMonitor::Capabilities::Builder.define do
        device "LVDS1", :mode => "1920x1080", :rate => "60.0"
      end

      assert_equal false, RMonitor::Matcher.new(:capabilities => capabilities).invokable?(profile)
    end

    it "should return false if :not_if returns true" do
      def foo
        true
      end

      profile = RMonitor::Profile::Builder.define "foo", :not_if => method(:foo) do
        device "LVDS1", :mode => "1920x1080", :rate => "60.0"
      end

      capabilities = RMonitor::Capabilities::Builder.define do
        device "LVDS1", :mode => "1920x1080", :rate => "60.0"
      end

      assert_equal false, RMonitor::Matcher.new(:capabilities => capabilities).invokable?(profile)
    end

    it "should otherwise return true" do
      profile = RMonitor::Profile::Builder.define "foo" do
        device "LVDS1", :mode => "1920x1080", :rate => "60.0"
      end

      capabilities = RMonitor::Capabilities::Builder.define do
        device "LVDS1", :mode => "1920x1080", :rate => "60.0"
      end

      assert_equal true, RMonitor::Matcher.new(:capabilities => capabilities).invokable?(profile)
    end

  end

end
