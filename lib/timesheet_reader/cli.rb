module TimesheetReader
    class CLI
        def run
            input = ARGV
            timesheet_info = TimesheetReader::Core.new(input).run

            TimesheetReader::Formatter.new.report(
                timesheet_info[:timesheets],
                timesheet_info[:total_hours],
                timesheet_info[:total_minutes],
            )
        end
    end
end
