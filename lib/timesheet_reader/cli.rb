module TimesheetReader
    class CLI
        def run
            input = ARGV
            puts Core.new(input).run
        end
    end
end
