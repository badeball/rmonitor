require "test_helper"

describe RMonitor::Capabilities do

  describe "#parse" do

    it "should correctly parse the most trivial case" do
      actual = RMonitor::Capabilities.new.parse <<-OUTPUT
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
      OUTPUT

      expected = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
      end

      assert_equal expected, actual
    end

    it "should correctly parse secondary rates for a mode" do
      actual = RMonitor::Capabilities.new.parse <<-OUTPUT
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0    30.0
      OUTPUT

      expected = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
        device "HDMI1", :mode => "1920x1080", :rate => "30.0"
      end

      assert_equal expected, actual
    end

    it "should correctly parse the current mode / rate" do
      actual = RMonitor::Capabilities.new.parse <<-OUTPUT
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0 +
      OUTPUT

      expected = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0", :current => true
      end

      assert_equal expected, actual
    end

    it "should correctly parse the native mode / rate" do
      actual = RMonitor::Capabilities.new.parse <<-OUTPUT
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0*
      OUTPUT

      expected = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0", :native => true
      end

      assert_equal expected, actual
    end

    it "should correctly parse multiple rates" do
      actual = RMonitor::Capabilities.new.parse <<-OUTPUT
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
           1400x1050       60.0
      OUTPUT

      expected = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
        device "HDMI1", :mode => "1400x1050", :rate => "60.0"
      end

      assert_equal expected, actual
    end

    it "should correctly parse multiple devices" do
      actual = RMonitor::Capabilities.new.parse <<-OUTPUT
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
        HDMI2 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
      OUTPUT

      expected = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
        device "HDMI2", :mode => "1920x1080", :rate => "60.0"
      end

      assert_equal expected, actual
    end

    it "should not parse disconnected devices" do
      actual = RMonitor::Capabilities.new.parse <<-OUTPUT
        Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 1920 x 1080
        HDMI1 connected (normal left inverted right x axis y axis)
           1920x1080       60.0
        HDMI2 disconnected (normal left inverted right x axis y axis)
      OUTPUT

      expected = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
      end

      assert_equal expected, actual
    end

  end

end
