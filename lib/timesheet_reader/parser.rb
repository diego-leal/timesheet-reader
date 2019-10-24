# frozen_string_literal: true

module TimesheetReader
  # ParserError class
  class ParserError < RuntimeError
    def initialize(message)
      super(message)
    end
  end

  # Parser class
  class Parser
    attr_accessor :keywords, :token

    def initialize
      @keyword = 'timesheet'
      @token = '##'
    end

    def run(relative_path)
      file = read_file(relative_path)
      lines = build_lines(file[:lines])

      { filename: file[:filename], lines: lines }
    end

    private

    def read_file(relative_path)
      absolute_path = File.expand_path(relative_path)
      _, filename = File.split(relative_path)
      lines = File.read(absolute_path).squeeze("\n").split("\n")

      { filename: filename, lines: lines }
    end

    def parse_statements_block(lines)
      token_index = lines.index do |line|
        line.downcase == "#{@token} #{@keyword}"
      end

      start_of_block = token_index + 1

      end_of_block = lines[start_of_block..-1].index do |line|
        line.include?(@token.to_s)
      end

      lines[start_of_block..end_of_block]
    end

    def build_lines(lines)
      parsed_lines = parse_statements_block(lines)
      validate_timesheet_intervals(parsed_lines)

      parsed_lines.map do |line|
        statement, hours, minutes = line.split(':')
        validate_time_sheet_hours(hours)
        validate_time_sheet_minutes(minutes)
        hours = hours.to_i.zero? ? 24 : hours.to_i

        { statement: statement, hours: hours, minutes: minutes.to_i }
      end
    end

    def validate_timesheet_intervals(lines)
      msg = 'You should close the interval of last line'
      raise ParserError, msg if lines.length.odd?
    end

    def validate_time_sheet_hours(hours)
      hours = hours.to_i
      msg = 'You should use a number between 0-23 to define hours'
      raise ParserError, msg if hours.negative? || hours > 23
    end

    def validate_time_sheet_minutes(minutes)
      minutes = minutes.to_i
      msg = 'You should use a number between 0-59 to define minutes'
      raise ParserError, msg if minutes.negative? || minutes > 59
    end
  end
end
