# frozen_string_literal: true

module TimesheetReader
  # Formatter class
  class Formatter
    def report(timesheets, total_hours, total_minutes)
      timesheets.each do |timesheet|
        filename = timesheet[:filename]
        hours = timesheet[:hours]
        minutes = timesheet[:minutes]

        print_timesheet_line(filename, hours, minutes)
      end

      hours = format_time(total_hours)
      minutes = format_time(total_minutes)
      puts "Total hours: #{hours}:#{minutes}"
    end

    private

    def format_time(time)
      '%02d' % time
    end

    def print_timesheet_line(filename, hours, minutes)
      puts "#{filename}: #{format_time(hours)}:#{format_time(minutes)} hours"
    end
  end
end
