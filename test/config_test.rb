require "test_helper"
require "fakefs/safe"
require "fileutils"

describe RMonitor::Config do

  describe "#read" do

    before :each do
      FakeFS.activate!
    end

    after :each do
      FakeFS.deactivate!
    end

    it "should by default return the content of ~/.config/rmonitor/config.rb" do
      FileUtils.mkdir_p "~/.config/rmonitor"
      File.write "~/.config/rmonitor/config.rb", "foo"

      assert_equal "foo", RMonitor::Config.new.read
    end

    it "should supported reading from arbritary locations as well" do
      RMonitor::Config.config_path = "/config.rb"
      File.write "/config.rb", "foo"

      assert_equal "foo", RMonitor::Config.new.read
    end

  end

end
