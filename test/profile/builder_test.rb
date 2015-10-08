require "test_helper"

describe RMonitor::Profile::Builder do

  describe "::define" do

    it "should return a profiles and its desired capabilities" do
      actual = RMonitor::Profile::Builder.define "docked" do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
        device "HDMI2", :mode => "1920x1080", :rate => "60.0"
      end

      expected = {
        :name => "docked",
        :devices => [
          {:name => "HDMI1", :mode => "1920x1080", :rate => "60.0"},
          {:name => "HDMI2", :mode => "1920x1080", :rate => "60.0"}
        ]
      }

      assert_equal expected, actual
    end

  end

end
