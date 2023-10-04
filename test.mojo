from mo_time import Instant, DateTimeLocal, Duration
from testing import assert_equal


# These are tests, I am not recommending that we add these in 😁
fn main():
    let now = Instant.now()

    let dt_utc = DateTimeLocal.now_utc()
    print("dt_utc: ", dt_utc.__str__())

    let dt_local = DateTimeLocal.now()
    print("dt_local: ", dt_local.__str__())
    let duration = Duration(0, 0, 0, 365, 0, 0)

    let dt2 = DateTimeLocal(2023, 9, 14, 0, 0, 0)
    _ = assert_equal(dt2.__str__(), "2023-09-14T00:00:00")

    let target_dt_str = "2024-09-14T00:00:00"
    _ = assert_equal(dt2.plus_years(1).__str__(), target_dt_str)
    _ = assert_equal(dt2.plus_months(12).__str__(), target_dt_str)
    _ = assert_equal(dt2.plus_days(366).__str__(), target_dt_str)
    _ = assert_equal(dt2.plus_hours(8784).__str__(), target_dt_str)
    _ = assert_equal(dt2.plus_minutes(527040).__str__(), target_dt_str)
    _ = assert_equal(dt2.plus_seconds(31622400).__str__(), target_dt_str)
