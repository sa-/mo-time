from mo_time.ctypes import ts_to_tm, _CTimeSpec, C_tm
from mo_time.duration import Duration, days_in_month


@value
struct Date:
    var year: Int32
    var month: Int32
    var day_of_month: Int32


@value
struct Time:
    var hour: Int32
    var minute: Int32
    var second: Int32


@value
struct DateTimeLocal:
    var second: Int32
    var minute: Int32
    var hour: Int32
    var day_of_month: Int32
    var month: Int32
    var year: Int32

    @staticmethod
    fn from_instant(instant: Instant) -> Self:
        """Defaults to UTC."""
        let ts = _CTimeSpec(instant.seconds, instant.nanos)
        let tm = ts_to_tm(ts)

        return DateTimeLocal._from_tm(tm)

    @staticmethod
    fn _from_tm(tm: C_tm) -> Self:
        return DateTimeLocal(
            tm.tm_sec,
            tm.tm_min,
            tm.tm_hour,
            tm.tm_mday,
            tm.tm_mon + 1,
            tm.tm_year + 1900,
        )

    @staticmethod
    fn now() -> Self:
        return DateTimeLocal.from_instant(Instant.now())

    fn plus_years(self, years: Int32) -> Self:
        return DateTimeLocal(
            self.second,
            self.minute,
            self.hour,
            self.day_of_month,
            self.month,
            self.year + years,
        )

    fn plus_months(self, months: Int32) -> Self:
        let new_year = self.year + (months / 12)
        let new_month = ((self.month - 1 + months) % 12) + 1
        return DateTimeLocal(
            self.second,
            self.minute,
            self.hour,
            self.day_of_month,
            new_month,
            new_year,
        )

    fn plus_days(self, days: Int32) -> Self:
        """Broken."""
        var new_day = days + self.day_of_month

        # handle overflow
        var overflow_months: Int32 = 0
        while new_day > days_in_month(
            self.year.__int__(), ((self.month + overflow_months) % 12).__int__()
        ):
            new_day -= days_in_month(
                self.year.__int__(), ((self.month + overflow_months) % 12).__int__()
            )
            overflow_months += 1

        let new_year = self.year + overflow_months / 12
        let new_month = ((self.month - 1 + overflow_months) % 12) + 1
        return DateTimeLocal(
            self.second,
            self.minute,
            self.hour,
            new_day,
            new_month,
            new_year,
        )

    fn plus_hours(self, hours: Int32) -> Self:
        let new_hour = (self.hour + hours) % 24

        let overflow_days = hours / 24

        return DateTimeLocal(
            self.second,
            self.minute,
            new_hour,
            self.day_of_month,
            self.month,
            self.year,
        ).plus_days(overflow_days)

    fn plus_minutes(self, minutes: Int32) -> Self:
        let new_minute = (self.minute + minutes) % 60
        let overflow_hours = minutes / 60
        return DateTimeLocal(
            self.second,
            new_minute,
            self.hour,
            self.day_of_month,
            self.month,
            self.year,
        ).plus_hours(overflow_hours)

    fn plus_seconds(self, seconds: Int32) -> Self:
        let new_second = (self.second + seconds) % 60
        let overflow_minutes = seconds / 60
        return DateTimeLocal(
            new_second,
            self.minute,
            self.hour,
            self.day_of_month,
            self.month,
            self.year,
        ).plus_minutes(overflow_minutes)

    fn __str__(self) -> String:
        # TODO use strftime
        return (
            String(self.year.to_int())
            + "-"
            + ("0" if self.month < 10 else "")
            + String(self.month.to_int())
            + "-"
            + ("0" if self.day_of_month < 10 else "")
            + String(self.day_of_month.to_int())
            + "T"
            + ("0" if self.hour < 10 else "")
            + String(self.hour.to_int())
            + ":"
            + ("0" if self.minute < 10 else "")
            + String(self.minute.to_int())
            + ":"
            + ("0" if self.second < 10 else "")
            + String(self.second.to_int())
        )
