require File.join(File.dirname(__FILE__), '../../../lib/devices')
require File.join(File.dirname(__FILE__), '../../../lib/helpers/profile_helpers')

describe RMonitor::ProfileHelpers do
  include RMonitor::ProfileHelpers

  describe :best_matching_configuration do
    context "no matching configuration" do
      it "should return nil" do
        device = parse_device <<-D.strip_heredoc
          HDMI1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 477mm x 268mm
             1920x1080      60.0*+
             1280x1024      75.0     60.0
             1152x864       75.0
             1024x768       75.1     60.0
             800x600        75.0     60.3
             640x480        75.0     60.0
             720x400        70.1
        D

        best_matching_configuration(device, "1280x768", nil).should == nil
      end
    end

    context "one matching configuration" do
      it "should return it" do
        device = parse_device <<-D.strip_heredoc
          HDMI1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 477mm x 268mm
             1920x1080      60.0*+
             1280x1024      75.0     60.0
             1152x864       75.0
             1024x768       75.1     60.0
             800x600        75.0     60.3
             640x480        75.0     60.0
             720x400        70.1
        D

        best_matching_configuration(device, "1920x1080", nil).should == { :mode => "1920x1080",
                                                                          :rate => "60.0" }
      end
    end

    context "more matching configurations due to no rate specified" do
      it "should return the 'best' configuration" do
        device = parse_device <<-D.strip_heredoc
          HDMI1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 477mm x 268mm
             1920x1080      60.0*+
             1280x1024      75.0     60.0
             1152x864       75.0
             1024x768       75.1     60.0
             800x600        75.0     60.3
             640x480        75.0     60.0
             720x400        70.1
        D

        best_matching_configuration(device, "1280x1024", nil).should == { :mode => "1280x1024",
                                                                          :rate => "75.0" }
      end
    end

    context "more matching configurations due to no mode specified" do
      it "should return the 'best' configuration" do
        device = parse_device <<-D.strip_heredoc
          HDMI1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 477mm x 268mm
             1920x1080      60.0*+
             1280x1024      75.0     60.0
             1152x864       75.0
             1024x768       75.1     60.0
             800x600        75.0     60.3
             640x480        75.0     60.0
             720x400        70.1
        D

        best_matching_configuration(device, nil, "60.0").should == { :mode => "1920x1080",
                                                                     :rate => "60.0" }
      end
    end
  end
end
