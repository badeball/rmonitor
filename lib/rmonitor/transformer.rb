class RMonitor
  class Transformer
    def transform(action)
      args = ["--output", action.delete(:name)]

      if action.delete(:action) == :off
        args << "--off"
      end

      action.each do |key, value|
        args << "--#{key.to_s.gsub("_", "-")}"

        unless value.is_a?(TrueClass)
          args << value.to_s
        end
      end

      args
    end
  end
end
