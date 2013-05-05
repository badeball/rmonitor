require File.join(File.dirname(__FILE__), 'lib', 'dsl')
require File.join(File.dirname(__FILE__), 'lib', 'xrandr')
require File.join(File.dirname(__FILE__), 'lib', 'profile')

module RMonitor
  CONFIG_PATH = File.join(Dir.home, '.config', 'rmonitor', 'config.rb')
  DEVICES     = XRandR.parse(`xrandr -q`)
  PROFILES    = DSL.parse(CONFIG_PATH) if File.exist?(CONFIG_PATH)
end
