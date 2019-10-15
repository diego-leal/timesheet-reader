class Parser
    attr_accessor :keywords, :token, :statements

    def initialize
        @statements = ["morning", "brb lunch", "brb", "back", "leaving"]
        @keyword = "timesheet"
        @token = "##"
    end

    def build (relative_path)
        file = read_file(relative_path)
        lines = sanitize_lines(file[:lines])

        return {
            filename: file[:filename],
            lines: lines
        }
    end

    private

    def read_file (relative_path)
        absolute_path = File.expand_path(relative_path)
        path, filename = File.split(relative_path)
        lines = []

        File.open(absolute_path).each do |line|
            lines.push(line)
        end

        return {
            filename: filename,
            lines: lines
        }
    end

    def parse_lines (lines)
        token_index = lines.index { |line| line.chop.downcase == "#{@token} #{@keyword}" }
        start_of_block = token_index + 1
        end_of_block = lines[start_of_block..].index { |line| line.include?("#{@token}") }
        lines_range = lines[start_of_block..end_of_block]

        return lines_range
    end

    def sanitize_lines (lines)
        parsed_lines = parse_lines(lines)
        sanitized_lines = []

        parsed_lines.each do |line|
            statement, hours, minutes = line.split(":")

            if statements.include?(statement)
                sanitized_lines.push({
                    statement: statement,
                    hours: hours.to_i,
                    minutes: minutes.to_i
                })
            end
        end

        return sanitized_lines
    end
end
