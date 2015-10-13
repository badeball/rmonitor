require File.join(File.dirname(__FILE__), "lib", "rmonitor", "version")

Gem::Specification.new do |s|
  s.name        = "rmonitor"
  s.version     = RMonitor::VERSION
  s.license     = "MIT"

  s.summary     = "A tool for defining monitor profiles that are easily invoked."
  s.description = "RMonitor is a tool for defining monitor profiles that can be invoked. This is useful when you often find yourself in situations with different monitor configurations."

  s.authors     = ["Jonas Amundsen"]
  s.email       = ["jonasba+gem@gmail.com"]
  s.homepage    = "https://github.com/badeball/rmonitor"

  s.executables = "rmonitor"
  s.files       = Dir["LICENSE", "README.md", "lib/**/*"]
  s.test_files  = Dir["test/**/*.rb"]

  s.add_dependency("commander", "4.3.4")

  s.add_development_dependency("codeclimate-test-reporter", "0.4.7")
  s.add_development_dependency("fakefs", "0.6.7")
  s.add_development_dependency("minitest", "5.5.1")
  s.add_development_dependency("minitest-reporters", "1.1.2")
  s.add_development_dependency("guard", "2.13.0")
  s.add_development_dependency("guard-minitest", "2.4.4")
  s.add_development_dependency("rake", "10.4.2")
end
