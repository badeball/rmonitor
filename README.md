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
    -c, --create [NAME]              Create and output a profile with an optional name
    -i, --invoke NAME                Invoke a profile with a given name
    -u, --update                     Invoke the most preferable profile
    -v, --verbose                    Verbose output
    -d, --dry-run                    Do everything except actually update
        --config-path PATH           Specify the path to the configuration file (defaults to ~/.config/rmonitor/config.rb
    -h, --help                       Show this message
        --version                    Print the version number of rmonitor
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

### --invoke NAME

Invokes a monitor profile by generating an xrandr query.

### --update

Parses the configuration file from top to bottom and invokes the first
invokable profile based on what devices that are currently connected. This is
likely the most used option and may for instance be used to automatically
configure your screens upon startup.

## Installation

The utility can be installed using `gem`, but is also packaged for Arch Linux.

```
$ gem install rmonitor
```

It can be installed system-wide using the following options.

```
$ gem install --no-user-install -i "$(ruby -e'puts Gem.default_dir')" -n /usr/bin rmonitor
```

### Arch Linux

```
$ yaourt -Syua ruby-rmonitor
```

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

## Changelog

### 1.0.0

* The -a option is removed.
* Fixed a bug that caused rates with of more than one decimal to not get picked up.
* Error messages are now outputted to stderr and the program exits with a non-zero status.
* The library is now turned into a gem.
* Added a --config-path option.
* Added a --version option.

### 0.0.9

* Added one-letter short options.
* Fixed an issue where it was impossible to specify DPI as an integer.

### 0.0.8

* Added a --dry-run option.
* Added a --verbose option.
* Added option for user defined rules to profiles.

An :only_if or :not_if option may be specified with a profile. The value
should correspond to a method defined within the configuration file and
should return whether or not the profile can be invoked.

The following code shows an example of how this is used.

```ruby
def laptop_lid_open?
  File.read('/proc/acpi/button/lid/LID/state').match(/open/)
end

profile "docked", :only_if => :laptop_lid_open? do
  device "LVDS1"
  device "VGA1", :right_of => "LVDS1"
end
```

### 0.0.7

* Added support for the --reflect directive.
* Added support for the --rotate directive.
* Added support for the --same-as directive.

### 0.0.6

* Added support for the --dpi directive.

### 0.0.5

* Fixing bug with finding best configuration.
* Added support for the --primary directive.

### 0.0.4

* The generated command for changing monitor profile now contains a part that first turns of all monitors.

### 0.0.3

* Correcting a bug in deducing invokability.

### 0.0.2

* Fixing bug with device specified without options.

### 0.0.1

* Initial work on the project.
