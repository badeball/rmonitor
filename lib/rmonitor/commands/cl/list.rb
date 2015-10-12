require "rmonitor/commands/list"

class RMonitor
  module Commands
    module CL
      class List
        def initialize(options = {})
          @out = options[:out] || $stdout
          @list = options[:list] || RMonitor::Commands::List.new(options)
          @matcher = options[:matcher] || RMonitor::Matcher.new(options)
        end

        def execute
          profiles = @list.execute

          profiles.each do |profile|
            @out.write("#{profile[:name]}\t")

            if @matcher.invokable?(profile)
              @out.write("invokable")
            else
              @out.write("uninvokable")
            end

            profile[:devices].each do |device|
              @out.write("\t#{device[:name]}")

              if device[:mode] && device[:rate]
                @out.write(" (#{device[:mode]} #{device[:rate]})")
              elsif device[:mode]
                @out.write(" (#{device[:mode]})")
              elsif device[:rate]
                @out.write(" (#{device[:rate]})")
              end
            end

            @out.write("\n")
          end
        end
      end
    end
  end
end
