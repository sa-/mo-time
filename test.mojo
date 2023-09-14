from mo_time import Instant, DateTimeLocal


# These are tests, I am not recommending that we add these in 😁
def main():
    let now = Instant.utc_now()
    let dt = DateTimeLocal.from_instant(now)
    print("second: ", dt.second)
    print("minute: ", dt.minute)
    print("hour: ", dt.hour)
    print("day_of_month: ", dt.day_of_month)
    print("month: ", dt.month)
    print("year: ", dt.year)
    print("weekday: ", dt.day_of_week)
    print("day_of_year: ", dt.day_of_year)
    print("is_daylight_savings: ", dt.is_daylight_savings)
