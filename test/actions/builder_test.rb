require "test_helper"

describe RMonitor::Actions::Builder do

  describe "::define" do

    it "should return an array consisting of actions" do
      actual = RMonitor::Actions::Builder.define do
        off "LVDS1"
        dpi 96
        on "HDMI1", :mode => "1920x1080", :rate => "60.0"
        on "HDMI2", :mode => "1920x1080", :rate => "60.0"
      end

      expected = [
        {:name => "LVDS1", :action => :off},
        {:name => :dpi, :value => 96, :action => :option},
        {:name => "HDMI1", :action => :on, :mode => "1920x1080", :rate => "60.0"},
        {:name => "HDMI2", :action => :on, :mode => "1920x1080", :rate => "60.0"}
      ]

      assert_equal expected, actual
    end

  end

end
