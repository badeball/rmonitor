require "test_helper"

describe RMonitor::Selector do

  describe "#first_invokable" do

    it "should return the first invokable profile" do
      profiles = [ # A bunch of dummy objects, representing profiles
        Object.new,
        Object.new,
        Object.new
      ]

      matcher = MiniTest::Mock.new

      matcher.expect :invokable?, false, [profiles[0]]
      matcher.expect :invokable?, true, [profiles[1]]
      matcher.expect :invokable?, false, [profiles[2]]

      selector = RMonitor::Selector.new(
        :profiles => profiles,
        :matcher => matcher
      )

      assert_equal profiles[1], selector.first_invokable
    end

  end

end
