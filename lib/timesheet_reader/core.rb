module TimesheetReader
    class Core
        attr_reader :file_paths, :parser, :converter

        def initialize (file_paths)
            @file_paths = file_paths
            @parser = TimesheetReader::Parser.new
            @converter = TimesheetReader::Converter.new
        end

        def run
             timesheets = transform_timesheets(
                generate_timesheets()
            )

            total_time = sum_time(timesheets)
            total_hours, total_minutes = @converter.minutes_to_time(total_time)

            {
                total_hours: total_hours,
                total_minutes: total_minutes,
                timesheets: timesheets
            }
        end

        private

        def generate_timesheets
            @file_paths.map { |path| @parser.run(path) }
        end

        def transform_timesheets (timesheets)
            timesheets.map do |timesheet|
                lines = map_time_to_minutes(timesheet[:lines])
                time = calculate_time_diff(lines)
                hours, minutes = @converter.minutes_to_time(time)

                {
                    filename: timesheet[:filename],
                    time: time,
                    hours: hours,
                    minutes: minutes
                }
            end
        end

        def map_time_to_minutes (timesheet_lines)
            timesheet_lines.map do |line|
                line[:minutes] + @converter.hour_to_minutes(line[:hours])
            end
        end

        def calculate_time_diff (lines_in_minutes)
            diffs = []

            lines_in_minutes.each_with_index do |time, index|
                next if index.odd?
                nextTime = lines_in_minutes[index + 1]
                diff = nextTime - time

                diffs.push(diff)
            end

            diffs.reduce(0) { |acc, time_diff| acc + time_diff }
        end

        def sum_time (timesheets)
            timesheets.reduce(0) { |acc, timesheet| acc + timesheet[:time] }
        end
    end
end
