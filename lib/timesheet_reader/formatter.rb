module TimesheetReader
    class Formatter
        def report (timesheets, total_hours, total_minutes)
            timesheets.each do |timesheet|
                filename = timesheet[:filename]
                hours = timesheet[:hours]
                minutes = timesheet[:minutes]

                print_timesheet_line(filename, hours, minutes)
            end

            puts "Total hours: #{format_time(total_hours)}:#{format_time(total_minutes)}"
        end

        private

        def format_time (time)
            time < 10 ? "0" << time.to_s : time.to_s
        end

        def print_timesheet_line (filename, hours, minutes)
            puts "#{filename}: #{format_time(hours)}:#{format_time(minutes)} hours"
        end
    end
end
