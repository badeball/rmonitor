class RMonitor
  class Config
    def read
      File.read self.class.config_path
    end

    class << self
      attr_writer :config_path

      def config_path
        @config_path || default_config_path
      end

      private

      def default_config_path
        File.join(Dir.home, ".config", "rmonitor", "config.rb")
      end
    end
  end
end
