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

        return {
            filename: file[:filename],
            lines: lines
        }
    end

    private

    def read_file (relative_path)
        absolute_path = File.expand_path(relative_path)
        path, filename = File.split(relative_path)
            lines = File.read(absolute_path).squeeze("\n").split("\n")

        return {
            filename: filename,
            lines: lines
        }
    end

        def parse_statements_block (lines)
            token_index = lines.index { |line| line.downcase == "#{@token} #{@keyword}" }
        start_of_block = token_index + 1
        end_of_block = lines[start_of_block..].index { |line| line.include?("#{@token}") }
        lines_range = lines[start_of_block..end_of_block]

        return lines_range
    end

        def build_lines (lines)
            parsed_lines = parse_statements_block(lines)
        sanitized_lines = []

        parsed_lines.each do |line|
            statement, hours, minutes = line.split(":")

                sanitized_lines.push({
                    statement: statement,
                    hours: hours.to_i,
                    minutes: minutes.to_i
                })
            end

        return sanitized_lines
    end
end
