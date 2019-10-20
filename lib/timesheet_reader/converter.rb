module TimesheetReader
    class Converter
        attr_accessor :minute_multiplier

        def initialize
            @minute_multiplier = 60
        end

        def hour_to_minutes (hours)
            hours.to_i * minute_multiplier
        end

        def minutes_to_time (minutes)
            hours = (minutes / @minute_multiplier)
            hours_part = (minutes % @minute_multiplier)
            [hours, hours_part]
        end
    end
end
