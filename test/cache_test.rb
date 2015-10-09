require "test_helper"

describe RMonitor::Cache do

  describe "#invoke" do

    it "should call Invoker#invoke the first time" do
      invoker = MiniTest::Mock.new
      invoker.expect :invoke, "foo", ["bar"]

      assert_equal "foo", RMonitor::Cache.new(:invoker => invoker).invoke("bar")

      invoker.verify
    end

    it "should return the cached reuslt the second time" do
      invoker = MiniTest::Mock.new
      invoker.expect :invoke, "foo", ["bar"]

      cache = RMonitor::Cache.new(:invoker => invoker)

      assert_equal "foo", cache.invoke("bar")
      assert_equal "foo", cache.invoke("bar")

      invoker.verify
    end

  end

end
