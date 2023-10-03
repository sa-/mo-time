from mo_time import Instant, DateTimeLocal, Duration


# These are tests, I am not recommending that we add these in 😁
fn main():
    let now = Instant.now()
    let dt = DateTimeLocal.now_utc()
    print(dt.__str__())
    let duration = Duration(0, 0, 0, 365, 0, 0)
    # let new_dt = dt.adjust(duration)
    # print(new_dt.__str__())

    let dt2 = DateTimeLocal(0, 0, 0, 14, 9, 2023)
    print(dt2.__str__())

    print(dt2.plus_years(1).__str__())
    print(dt2.plus_months(12).__str__())
    print(dt2.plus_days(366).__str__())
    print(dt2.plus_hours(8784).__str__())
    print(dt2.plus_minutes(527040).__str__())
    print(dt2.plus_seconds(31622400).__str__())
