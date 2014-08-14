require File.join(File.dirname(__FILE__), 'lib', 'rmonitor', 'version')

Gem::Specification.new do |s|
  s.name        = 'rmonitor'
  s.version     = RMonitor::VERSION
  s.license     = 'MIT'
  s.date        = '2014-08-14'

  s.summary     = 'A tool for creating monitor profiles that are easily invoked.'
  s.description = 'RMonitor is a tool for creating monitor profiles that are easily invoked. This is useful when you often find yourself in situations with different monitor configurations.'

  s.authors     = ['Jonas Amundsen']
  s.email       = ['jonasba+gem@gmail.com']
  s.homepage    = 'https://github.com/badeball/rmonitor'

  s.executables = 'rmonitor'

  s.files       = %w[
    bin/rmonitor
    lib/rmonitor/helpers/dsl_helpers.rb
    lib/rmonitor/helpers/profile_helpers.rb
    lib/rmonitor/helpers/xrandr_read_helpers.rb
    lib/rmonitor/helpers/xrandr_write_helpers.rb
    lib/rmonitor/devices.rb
    lib/rmonitor/profiles.rb
    lib/rmonitor/version.rb
    lib/rmonitor.rb
    spec/lib/helpers/dsl_helper_spec.rb
    spec/lib/helpers/profile_helpers_spec.rb
    spec/lib/helpers/xrandr_read_helpers_spec.rb
    spec/lib/helpers/xrandr_write_helpers_spec.rb
    spec/support/device_helper.rb
    spec/support/profile_helper.rb
    spec/support/string_helpers.rb
    .rspec
    Gemfile
    Gemfile.lock
    LICENSE
    README.md
    rmonitor.gemspec
  ]

  s.add_development_dependency('rspec')
end
