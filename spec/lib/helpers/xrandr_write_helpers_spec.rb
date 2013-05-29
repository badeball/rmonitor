require File.join(File.dirname(__FILE__), '../../../lib/helpers/xrandr_write_helpers')

describe RMonitor::XRandRWriteHelpers do
  include RMonitor::XRandRWriteHelpers

  describe :turn_off do
    it "should return an appropriate XRandR directive for turning off a device" do
      turn_off("HDMI1").should == "--output HDMI1 --off"
    end
  end

  describe :turn_on do
    it "should return a XRandR directive containing mode and rate when nothing else is specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
      }

      turn_on("HDMI1", options).should ==
          "--output HDMI1 --mode 1920x1080 --rate 60.0"
    end

    it "should return a XRandR directive containing --pos when specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :pos => "1920x0",
      }

      turn_on("HDMI1", options).should ==
          "--output HDMI1 --mode 1920x1080 --rate 60.0 --pos 1920x0"
    end

    it "should return a XRandR directive containing --left-of when specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :left_of => "HDMI1",
      }

      turn_on("HDMI2", options).should ==
          "--output HDMI2 --mode 1920x1080 --rate 60.0 --left-of HDMI1"
    end

    it "should return a XRandR directive containing --right-of when specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :right_of => "HDMI1",
      }

      turn_on("HDMI2", options).should ==
          "--output HDMI2 --mode 1920x1080 --rate 60.0 --right-of HDMI1"
    end

    it "should return a XRandR directive containing --above when specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :above => "HDMI1",
      }

      turn_on("HDMI2", options).should ==
          "--output HDMI2 --mode 1920x1080 --rate 60.0 --above HDMI1"
    end

    it "should return a XRandR directive containing --below when specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :below => "HDMI1",
      }

      turn_on("HDMI2", options).should ==
          "--output HDMI2 --mode 1920x1080 --rate 60.0 --below HDMI1"
    end

    it "should return a XRandR directive containing --same-as when specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :same_as => "LVDS1",
      }

      turn_on("HDMI2", options).should ==
          "--output HDMI2 --mode 1920x1080 --rate 60.0 --same-as LVDS1"
    end

    it "should return a XRandR directive containing only one option specifying placement when given multiple" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :pos => "1920x0",
          :left_of => "HDMI1",
          :right_of => "HDMI1",
          :above => "HDMI1",
          :same_as => "LVDS1",
          :below => "HDMI1",
      }

      turn_on("HDMI2", options).should ==
          "--output HDMI2 --mode 1920x1080 --rate 60.0 --pos 1920x0"
    end

    it "should return a XRandR directive containing --primary when specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :primary => true,
      }

      turn_on("HDMI2", options).should ==
          "--output HDMI2 --mode 1920x1080 --rate 60.0 --primary"
    end

    it "should return a XRandR directive containing --rotate when specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :rotate => "normal",
      }

      turn_on("HDMI2", options).should ==
          "--output HDMI2 --mode 1920x1080 --rate 60.0 --rotate normal"
    end

    it "should raise an exception if a wrong --rotate directive is specified" do
      options = {
          :mode => "1920x1080",
          :rate => "60.0",
          :rotate => "this does not exist",
      }

      lambda { turn_on("HDMI2", options) }.should raise_error
    end
  end
end
