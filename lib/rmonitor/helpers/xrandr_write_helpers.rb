module RMonitor
  module XRandRWriteHelpers
    def turn_off(device)
      "--output #{device} --off"
    end

    def turn_on(device, options)
      on = '--output %s --mode %s --rate %s' % [
          device,
          options[:mode],
          options[:rate],
      ]

      if options[:pos]
        on << ' --pos '      << options[:pos]
      elsif options[:left_of]
        on << ' --left-of '  << options[:left_of]
      elsif options[:right_of]
        on << ' --right-of ' << options[:right_of]
      elsif options[:above]
        on << ' --above '    << options[:above]
      elsif options[:below]
        on << ' --below '    << options[:below]
      elsif options[:same_as]
        on << ' --same-as '  << options[:same_as]
      end

      if options[:rotate]
        allowed_options = %w(normal inverted left right)

        if allowed_options.include?(options[:rotate])
          on << ' --rotate ' << options[:rotate]
        else
          raise XRandRArgumentError.new("Invalid argument for --rotate")
        end
      end

      if options[:reflect]
        allowed_options = %w(normal x y xy)

        if allowed_options.include?(options[:reflect])
          on << ' --reflect ' << options[:reflect]
        else
          raise XRandRArgumentError.new("Invalid argument for --reflect")
        end
      end

      if options[:primary]
        on << ' --primary'
      end

      on
    end
  end
end
