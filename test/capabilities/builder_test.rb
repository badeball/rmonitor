require "test_helper"

describe RMonitor::Capabilities::Builder do

  describe "::define" do

    it "should return an array consisting of device name and options" do
      actual = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
        device "HDMI2", :mode => "1920x1080", :rate => "60.0"
      end

      expected = [
        {:name => "HDMI1", :mode => "1920x1080", :rate => "60.0"},
        {:name => "HDMI2", :mode => "1920x1080", :rate => "60.0"}
      ]

      assert_equal expected, actual
    end

  end

end
