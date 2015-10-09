require "test_helper"

describe RMonitor::Config::Builder do

  describe "::define" do

    it "should return an array of profiles and their desired capabilities" do
      actual = RMonitor::Config::Builder.define do
        profile "docked" do
          device "HDMI1", :mode => "1920x1080", :rate => "60.0"
          device "HDMI2", :mode => "1920x1080", :rate => "60.0"
        end

        profile "default" do
          device "eDP1", :mode => "1920x1080"
        end
      end

      expected = [{
        :name => "docked",
        :devices => [
          {:name => "HDMI1", :mode => "1920x1080", :rate => "60.0"},
          {:name => "HDMI2", :mode => "1920x1080", :rate => "60.0"}
        ]
      }, {
        :name => "default",
        :devices => [
          {:name => "eDP1", :mode => "1920x1080"}
        ]
      }]

      assert_equal expected, actual
    end

    it "should attach methods to the :only_if :not_if options" do
      profiles = RMonitor::Config::Builder.define do
        def foo; end
        def bar; end

        profile "default", :only_if => :foo, :not_if => :bar do
          device "eDP1", :mode => "1920x1080"
        end
      end

      assert_kind_of Method, profiles.first[:only_if]
      assert_kind_of Method, profiles.first[:not_if]
    end

  end

end
