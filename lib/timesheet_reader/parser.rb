module TimesheetReader
    class ParserError < RuntimeError
        def initialize (message)
            super(message)
        end
    end

    class Parser
        attr_accessor :keywords, :token

        def initialize
            @keyword = "timesheet"
            @token = "##"
        end

        def run (relative_path)
            file = read_file(relative_path)
            lines = build_lines(file[:lines])

            { filename: file[:filename], lines: lines }
        end

        private

        def read_file (relative_path)
            absolute_path = File.expand_path(relative_path)
            path, filename = File.split(relative_path)
            lines = File.read(absolute_path).squeeze("\n").split("\n")

            { filename: filename, lines: lines }
        end

        def parse_statements_block (lines)
            token_index = lines.index { |line| line.downcase == "#{@token} #{@keyword}" }
            start_of_block = token_index + 1
            end_of_block = lines[start_of_block..].index { |line| line.include?("#{@token}") }
            lines[start_of_block..end_of_block]
        end

        def build_lines (lines)
            parsed_lines = parse_statements_block(lines)

            validate_timesheet_intervals(parsed_lines)

            parsed_lines.map do |line|
                statement, hours, minutes = line.split(":")

                validate_time_sheet_hours(hours)
                validate_time_sheet_minutes(minutes)

                {
                    statement: statement,
                    hours: hours.to_i == 0 ? 24 : hours.to_i,
                    minutes: minutes.to_i
                }
            end
        end

        def validate_timesheet_intervals (lines)
            raise ParserError.new("You should close the interval of last line") if lines.length.odd?
        end

        def validate_time_sheet_hours (hours)
            hours = hours.to_i
            raise ParserError.new("You should use a number between 0-23 to define hours") if hours < 0 || hours > 23
        end

        def validate_time_sheet_minutes (minutes)
            minutes = minutes.to_i
            raise ParserError.new("You should use a number between 0-59 to define minutes") if minutes < 0 || minutes > 59
        end
    end
end
