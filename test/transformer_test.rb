require "test_helper"

describe RMonitor::Transformer do

  describe "#transform" do

    it "should transform the :name option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1"], transformation
    end

    it "should transform the :mode option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :mode => "1920x1080"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--mode", "1920x1080"], transformation
    end

    it "should transform the :rate option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :rate => "60.0"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--rate", "60.0"], transformation
    end

    it "should transform the :primary option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :primary => true
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--primary"], transformation
    end

    it "should transform the :pos option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :pos => "1920x0"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--pos", "1920x0"], transformation
    end

    it "should transform the :left_of option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :left_of => "HDMI2"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--left-of", "HDMI2"], transformation
    end

    it "should transform the :right_of option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :right_of => "HDMI2"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--right-of", "HDMI2"], transformation
    end

    it "should transform the :above option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :above => "HDMI2"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--above", "HDMI2"], transformation
    end

    it "should transform the :below option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :below => "HDMI2"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--below", "HDMI2"], transformation
    end

    it "should transform the :same_as option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :same_as => "HDMI2"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--same-as", "HDMI2"], transformation
    end

    it "should transform the :transform option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :transform => :normal
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--transform", "normal"], transformation
    end

    it "should transform the :rotate option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :rotate => :normal
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--rotate", "normal"], transformation
    end

    it "should transform the :reflect option" do
      actions = RMonitor::Actions::Builder.define do
        on "HDMI1", :reflect => :normal
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--reflect", "normal"], transformation
    end

    it "should transform actions of type :off" do
      actions = RMonitor::Actions::Builder.define do
        off "HDMI1"
      end

      transformation = RMonitor::Transformer.new.transform(actions.first)

      assert_equal ["--output", "HDMI1", "--off"], transformation
    end

  end

end
