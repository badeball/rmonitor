require "test_helper"
require "stringio"

describe RMonitor::Commands::CL::Invoke do

  describe "#execute" do

    it "should write to :err when RMonitor::Commands::Invoke raises UnknownProfileError" do
      err = StringIO.new

      non_cl_invoke = Object.new

      def non_cl_invoke.execute(*)
        raise RMonitor::UnknownProfileError
      end

      RMonitor::Commands::CL::Invoke.new(:invoke => non_cl_invoke, :err => err).execute("foo")

      assert_equal "unknown profile\n", err.string
    end

    it "should write to :err when RMonitor::Commands::Invoke raises UninvokableProfileError" do
      err = StringIO.new

      non_cl_invoke = Object.new

      def non_cl_invoke.execute(*)
        raise RMonitor::UninvokableProfileError
      end

      RMonitor::Commands::CL::Invoke.new(:invoke => non_cl_invoke, :err => err).execute("foo")

      assert_equal "profile is not invokable\n", err.string
    end

  end

end
