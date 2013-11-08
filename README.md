## RMonitor

[![Build Status](https://travis-ci.org/badeball/rmonitor.png)](https://travis-ci.org/badeball/rmonitor)

RMonitor is a tool for creating monitor profiles that are easily invoked. This
is useful when you often find yourself in situations with different monitor
configurations. It consists of one executable and a ruby configuration file.
The following example shows a configuration containing monitor profiles
representing three different monitor setups.

```ruby
profile "docked" do
  device "HDMI1", :mode => "1920x1080", :rate => "60.0"
  device "HDMI2", :mode => "1920x1080", :rate => "60.0", :right_of => "HDMI1"
end

profile "projector" do
  device "LVDS1", :mode => "1280x800", :rate => "60.0"
  device "VGA1", :right_of => "LVDS1"
end

profile "default" do
  device "LVDS1"
end
```

Usage:

```
Usage: rmonitor [option]
    -a, --append [NAME]              Create a profile with an optional name and append it to the config (~/.config/rmonitor/config.rb)
    -c, --create [NAME]              Create and output a profile with an optional name
    -i, --invoke NAME                Invoke a profile with a given name
    -u, --update                     Invoke the most preferable profile
    -v, --verbose                    Verbose output
    -d, --dry-run                    Do everything except actually update
    -h, --help                       Show this message
```

### --create [NAME]

Outputs a profile for your current setup.

```
$ rmonitor --create "docked"
profile "docked" do
  device "HDMI1", :mode => "1920x1080", :rate => "60.0", :pos => "0x0"
  device "HDMI2", :mode => "1920x1080", :rate => "60.0", :pos => "1920x0"
end
```

### --append [NAME]

Runs rmonitor with --create and appends the result to the configuration file.

### --invoke NAME

Invokes a monitor profile by generating an xrandr query.

### --update

Parses the configuration file from top to bottom and invokes the first
invokable profile based on what devices that are currently connected. This is
likely the most used option and may for instance be used to automatically
configure your screens upon startup.

## Configurable options

The following examples shows how RMonitor can be configured.

```ruby
# Specify device location with position
profile "docked" do
  device "HDMI1", :pos => "0x0"
  device "HDMI2", :pos => "1920x0"
end
```

```ruby
# Specify device location relative to another device
# Similar options include :left_of, :above, :below
profile "docked" do
  device "HDMI1"
  device "HDMI2", :right_of => "HDMI1"
end
```

```ruby
# Specify device mode (resolution), best rate is chosen automatically
profile "docked" do
  device "HDMI1", :mode => "1920x1080"
  device "HDMI2", :mode => "1920x1080"
end
```

```ruby
# Specify device rate, best mode (resolution is chosen automatically
profile "docked" do
  device "HDMI1", :rate => "60.0"
  device "HDMI2", :rate => "60.0"
end
```

```ruby
# Specify device mode (resolution) and rate
profile "docked" do
  device "HDMI1", :mode => "1920x1080", :rate => "60.0"
  device "HDMI2", :mode => "1920x1080", :rate => "60.0"
end
```

```ruby
# Specify dpi (dots per inch)
profile "docked", :dpi => 96 do
  device "HDMI1"
  device "HDMI2"
end
```
