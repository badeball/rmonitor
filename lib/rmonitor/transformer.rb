class RMonitor
  class Transformer
    def transform(action)
      case action.delete(:action)
        when :off
          transform_off(action)
        when :on
          transform_on(action)
        when :option
          transforn_option(action)
      end
    end

    private

    def transform_on(action)
      args = ["--output", action.delete(:name)]

      action.each do |key, value|
        args << "--#{key.to_s.gsub("_", "-")}"

        unless value.is_a?(TrueClass)
          args << value.to_s
        end
      end

      args
    end

    def transform_off(action)
      ["--output", action.delete(:name), "--off"]
    end

    def transforn_option(action)
      ["--#{action[:name].to_s.gsub("_", "-")}", action[:value].to_s]
    end
  end
end
