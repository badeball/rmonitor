class RMonitor
  class Actions
    class DSL
      attr_accessor :actions

      def initialize
        @actions = []
      end

      def off(name)
        @actions << {:action => :off, :name => name}
      end

      def on(name, options = {})
        @actions << options.merge(:action => :on, :name => name)
      end

      def dpi(value)
        @actions << {:action => :option, :name => :dpi, :value => value}
      end
    end
  end
end
