require "test_helper"
require "stringio"

describe RMonitor::Commands::CL::Update do

  describe "#execute" do

    it "should write to :err when RMonitor::Commands::Update raises NoInvokableProfileError" do
      err = StringIO.new

      non_cl_update = Object.new

      def non_cl_update.execute
        raise RMonitor::NoInvokableProfileError
      end

      RMonitor::Commands::CL::Update.new(:update => non_cl_update, :err => err).execute

      assert_equal "no invokable profile\n", err.string
    end

  end

end
