class Conversor
    attr_accessor :minute_multiplier,
        :hour_multiplier,
        :day_multiplier,
        :week_multiplier,
        :month_multiplier,
        :year_multiplier

    def initialize
        @minute_multiplier = 60
        @hour_multiplier = 24
        @day_multiplier = 7
        @week_multiplier = 4
        @month_multiplier = 12
    end

    def hour_to_minutes (hours)
       return  hours.to_i * minute_multiplier;
    end

    def day_to_hours (days)
        return days.to_i * hour_multiplier
    end

    def day_to_minutes (days)
        hours =  day_to_hours(days)
        return hour_to_minutes(hours)
    end

    def week_to_days (weeks)
        return weeks.to_i * day_multiplier
    end

    def week_to_minutes (weeks)
        days = week_to_days(weeks)
        hours = day_to_hours(days)
        return hour_to_minutes(hours)
    end

    def month_to_weeks (months)
        return months.to_i * week_multiplier
    end

    def month_to_minutes (months)
        weeks = month_to_weeks(months)
        days = week_to_days(weeks)
        hours = day_to_hours(days)
        return hour_to_minutes(hours)
    end

    def year_to_minutes (years)
        months = years.to_i * month_multiplier
        weeks = month_to_weeks(months)
        days = week_to_days(weeks)
        hours = day_to_hours(days)
        return hour_to_minutes(hours)
    end
end
