module RMonitor
  module XRandRWriteHelpers
    def turn_off(device)
      '--output %s --off' % [device]
    end

    def turn_on(device, options)
      on = '--output %s --mode %s --rate %s' % [
          device,
          options[:mode],
          options[:rate],
      ]

      if options[:pos]
        on << ' --pos %s'      % [options[:pos]]
      elsif options[:left_of]
        on << ' --left-of %s'  % [options[:left_of]]
      elsif options[:right_of]
        on << ' --right-of %s' % [options[:right_of]]
      elsif options[:above]
        on << ' --above %s'    % [options[:above]]
      elsif options[:below]
        on << ' --below %s'    % [options[:below]]
      end

      if options[:primary]
        on << ' --primary'
      end

      on
    end
  end
end