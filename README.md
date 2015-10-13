## RMonitor

[![Build Status](https://travis-ci.org/badeball/rmonitor.png)](https://travis-ci.org/badeball/rmonitor)
[![Code Climate](https://codeclimate.com/github/badeball/rmonitor/badges/gpa.svg)](https://codeclimate.com/github/badeball/rmonitor)
[![Test Coverage](https://codeclimate.com/github/badeball/rmonitor/badges/coverage.svg)](https://codeclimate.com/github/badeball/rmonitor/coverage)

RMonitor is a tool for defining monitor profiles that can be invoked. This is
useful when you often find yourself in situations with different monitor
configurations. The following example shows a configuration containing monitor
profiles representing three different setups.

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

A configuration is parsed and considered from top to bottom. The first profile
that is currently invokable (ie. the requested devices with modes and rates are
available) is preferred. Profiles can also be invoked by name. `xrandr` is used
behind the scenes to read devices and perform changes.

## Installation

The utility can be installed using `gem`.

```
$ gem install rmonitor
```

It can be installed system-wide using the following options.

```
$ gem install --no-user-install -i "$(ruby -e'puts Gem.default_dir')" -n /usr/local/bin rmonitor
```

It is also packaged for Arch Linux.

```
$ yaourt -S ruby-rmonitor
```

## Usage

The executable contains three sub-commands. `invoke` will invoke a monitor
profile by name.

```
$ rmonitor invoke --name "docked"
```

The `update` command will invoke the most preferred monitor profile. This
command can be mapped to XF86Display to achieve the functionality that one can
see in eg, windows or apple machines.

```
$ rmonitor update
```

Lastly there is `list` which just list all defined monitor profiles.

```
$ rmonitor list
```

## Configurable options

The following examples shows how RMonitor can be configured. The default
configuration path is `~/.config/rmonitor/config.rb`, but can be configured
using the `--config-path` argument.

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

### 2.0.0

* Re-implementing the --config-path option.
* Re-implementing the :dpi profile option.

### 2.0.0.rc2

* Relaxing the regular expression for matching device names. Previously it
  would not match eg. `DP1-1`, but now it does.

### 2.0.0.rc1

* Complete revamp of the codebase. Test coverage is wastly better. The code is
  more maintainable and ready for change.

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
