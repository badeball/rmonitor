class RMonitor
  class XRandR
    def initialize(options = {})
      @invoker = options[:invoker] || Invoker.new(options)
      @out = options[:out] || $stdout
      @verbose = options[:verbose]
      @dry_run = options[:dry_run]
    end

    def invoke(*args)
      command = ("xrandr " + args.join(" ")).strip
      @out.puts command if @verbose
      @invoker.invoke(command) if args.empty? || !@dry_run
    end
  end
end
