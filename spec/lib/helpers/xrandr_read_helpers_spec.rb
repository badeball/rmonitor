require File.join(File.dirname(__FILE__), '../../../lib/helpers/xrandr_read_helpers')

describe RMonitor::XRandRReadHelpers do
  include RMonitor::XRandRReadHelpers

  describe :split_blocks do
    it "should split each block" do
      device_data = <<-X.strip_heredoc
        Screen 0: minimum 320 x 200, current 3840 x 1080, maximum 8192 x 8192
        LVDS1 connected (normal left inverted right x axis y axis)
           1280x800       60.0 +
           1024x768       60.0
           800x600        60.3     56.2
           640x480        59.9
        VGA1 disconnected (normal left inverted right x axis y axis)
      X

      split_blocks(device_data).should == [<<-X1.strip_heredoc, <<-X2.strip_heredoc, <<-X3.strip_heredoc]
        Screen 0: minimum 320 x 200, current 3840 x 1080, maximum 8192 x 8192
      X1
        LVDS1 connected (normal left inverted right x axis y axis)
           1280x800       60.0 +
           1024x768       60.0
           800x600        60.3     56.2
           640x480        59.9
      X2
        VGA1 disconnected (normal left inverted right x axis y axis)
      X3
    end
  end

  describe :collect_devices do
    it "should filter out blocks not representing a device" do
      blocks = [<<-X1.strip_heredoc, <<-X2.strip_heredoc, <<-X3.strip_heredoc]
        Screen 0: minimum 320 x 200, current 3840 x 1080, maximum 8192 x 8192
      X1
        LVDS1 connected (normal left inverted right x axis y axis)
           1280x800       60.0 +
           1024x768       60.0
           800x600        60.3     56.2
           640x480        59.9
      X2
        VGA1 disconnected (normal left inverted right x axis y axis)
      X3

      collect_devices(blocks) == [<<-X1.strip_heredoc, <<-X2.strip_heredoc]
        LVDS1 connected (normal left inverted right x axis y axis)
           1280x800       60.0 +
           1024x768       60.0
           800x600        60.3     56.2
           640x480        59.9
      X1
        VGA1 disconnected (normal left inverted right x axis y axis)
      X2
    end
  end

  describe :extract_name do
    it "should extract the name from a device block" do
      block = <<-X.strip_heredoc
        LVDS1 connected (normal left inverted right x axis y axis)
           1280x800       60.0 +
           1024x768       60.0
           800x600        60.3     56.2
           640x480        59.9
      X

      extract_name(block).should == "LVDS1"
    end
  end

  describe :extract_pos do
    context "with an disabled device" do
      it "should return nil" do
        block = <<-X.strip_heredoc
          VGA1 disconnected (normal left inverted right x axis y axis)
        X

        extract_pos(block).should == nil
      end
    end

    context "with an enabled device" do
      it "should return the position" do
        block = <<-X.strip_heredoc
          HDMI2 connected 1920x1080+1920+0 (normal left inverted right x axis y axis) 477mm x 268mm
             1920x1080      60.0*+
             1280x1024      75.0     60.0
             1152x864       75.0
             1024x768       75.1     60.0
        X

        extract_pos(block).should == "1920x0"
      end
    end

    context "with an enabled and disconncted device" do
      it "should return the position" do
        block = <<-X.strip_heredoc
          HDMI2 disconnected 1920x1080+1920+0 (normal left inverted right x axis y axis) 477mm x 268mm
        X

        extract_pos(block).should == "1920x0"
      end
    end
  end

  describe :extract_enabled do
    it "should return false if the device is disabled" do
      block = <<-X.strip_heredoc
        LVDS1 connected (normal left inverted right x axis y axis)
           1280x800       60.0 +
           1024x768       60.0
           800x600        60.3     56.2
           640x480        59.9
      X

      extract_enabled(block).should be_false
    end

    it "should return true if the device is enabled" do
      block = <<-X.strip_heredoc
        HDMI1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 477mm x 268mm
           1920x1080      60.0*+
           1280x1024      75.0     60.0
           1152x864       75.0
           1024x768       75.1     60.0
      X

      extract_enabled(block).should be_true
    end
  end

  describe :extract_connected do
    it "should return false if the device is disconnected" do
      block = <<-X.strip_heredoc
        VGA1 disconnected (normal left inverted right x axis y axis)
      X

      extract_connected(block).should be_false
    end

    it "should return true if the device is connected" do
      block = <<-X.strip_heredoc
        LVDS1 connected (normal left inverted right x axis y axis)
           1280x800       60.0 +
           1024x768       60.0
           800x600        60.3     56.2
           640x480        59.9
      X

      extract_connected(block).should be_true
    end
  end

  describe :extract_configuration do
    context "with no current configuration" do
      it "should return nil" do
        block = <<-X.strip_heredoc
          LVDS1 connected (normal left inverted right x axis y axis)
             1280x800       60.0 +
             1024x768       60.0
             800x600        60.3
             640x480        59.9
        X

        extract_configuration(block).should == nil
      end
    end

    context "with a current configuration" do
      it "should return the current configuration" do
        block = <<-X.strip_heredoc
          HDMI1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 477mm x 268mm
             1920x1080      60.0*+
             1280x1024      75.0     60.0
             1152x864       75.0
             1024x768       75.1     60.0
        X

        extract_configuration(block).should == { :mode => "1920x1080",
                                                 :rate => "60.0" }
      end
    end
  end

  describe :extract_configurations do
    context "with no configurations" do
      it "should return an empty array" do
        block = <<-X.strip_heredoc
          VGA1 disconnected (normal left inverted right x axis y axis)
        X

        extract_configurations(block).should == []
      end
    end

    context "with multiple modes" do
      it "should return all possible configurations" do
        block = <<-X.strip_heredoc
          LVDS1 connected (normal left inverted right x axis y axis)
             1280x800       60.0 +
             1024x768       60.0
             800x600        60.3
             640x480        59.9
        X

        extract_configurations(block).should == [{ :mode => '1280x800', :rate => '60.0' },
                                                 { :mode => '1024x768', :rate => '60.0' },
                                                 { :mode => '800x600',  :rate => '60.3' },
                                                 { :mode => '640x480',  :rate => '59.9' }]
      end
    end

    context "with multiple rates per mode" do
      it "should return all possible configurations" do
        block = <<-X.strip_heredoc
          LVDS1 connected (normal left inverted right x axis y axis)
             1280x800       60.0 +
             1024x768       60.0
             800x600        60.3     56.2
             640x480        59.9
        X

        extract_configurations(block).should == [{ :mode => '1280x800', :rate => '60.0' },
                                                 { :mode => '1024x768', :rate => '60.0' },
                                                 { :mode => '800x600',  :rate => '60.3' },
                                                 { :mode => '800x600',  :rate => '56.2' },
                                                 { :mode => '640x480',  :rate => '59.9' }]
      end
    end
  end
end
