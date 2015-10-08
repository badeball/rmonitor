require "test_helper"

describe RMonitor::Actions do

  describe "#create" do

    it "should create on actions for used monitors" do
      capabilities = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
        device "HDMI2", :mode => "1920x1080", :rate => "60.0"
      end

      profile = RMonitor::Profile::Builder.define "docked" do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
      end

      on_actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :mode => "1920x1080", :rate => "60.0"
      end

      assert_subset_of RMonitor::Actions.new(:capabilities => capabilities).create(profile), on_actions
    end

    it "should create off actions for unused monitors" do
      capabilities = RMonitor::Capabilities::Builder.define do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
        device "HDMI2", :mode => "1920x1080", :rate => "60.0"
      end

      profile = RMonitor::Profile::Builder.define "docked" do
        device "HDMI1", :mode => "1920x1080", :rate => "60.0"
      end

      off_actions = RMonitor::Actions::Builder.define do
        off "HDMI2"
      end

      assert_subset_of RMonitor::Actions.new(:capabilities => capabilities).create(profile), off_actions
    end

  end

end
