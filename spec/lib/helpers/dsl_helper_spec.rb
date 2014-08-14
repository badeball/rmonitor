require 'rmonitor/helpers/dsl_helpers'

describe RMonitor::DSLHelpers::ProfileBuilder do
  context "with :only_if being present" do
    it "should replace the symbol with the respective method proc" do
      profile_parser = RMonitor::DSLHelpers::ProfileBuilder.new

      profile_parser.define_singleton_method(:user_defined_rule) do
        # No operation
      end

      profile_parser.profile("dummy profile", :only_if => :user_defined_rule) do end
      profile_parser.profiles.first[:options][:only_if].is_a?(Method).should be_true
    end
  end

  context "with :not_if being present" do
    it "should replace the symbol with the respective method proc" do
      profile_parser = RMonitor::DSLHelpers::ProfileBuilder.new

      profile_parser.define_singleton_method(:user_defined_rule) do
        # No operation
      end

      profile_parser.profile("dummy profile", :not_if => :user_defined_rule) do end
      profile_parser.profiles.first[:options][:not_if].is_a?(Method).should be_true
    end
  end
end
