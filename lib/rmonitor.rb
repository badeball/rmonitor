require "rmonitor/commands/invoke"
require "rmonitor/commands/list"
require "rmonitor/commands/update"
require "rmonitor/strategies/optimistic"
require "rmonitor/strategies/pessimistic"
require "rmonitor/actions"
require "rmonitor/cache"
require "rmonitor/capabilities"
require "rmonitor/config"
require "rmonitor/invoker"
require "rmonitor/matcher"
require "rmonitor/selector"
require "rmonitor/transformer"
require "rmonitor/xrandr"

class RMonitor
  class UnknownProfileError < StandardError; end
  class UninvokableProfileError < StandardError; end
  class NoInvokableProfileError < StandardError; end
end
