from mo_time.ctypes import ts_to_local_tm, ts_to_utc_tm, _CTimeSpec, C_tm
from mo_time.duration import Duration, days_in_month


@value
struct Date:
    var year: Int32
    var month: Int32
    var day: Int32


@value
struct Time:
    var hour: Int32
    var minute: Int32
    var second: Int32


@value
struct DateTimeLocal:
    var year: Int32
    var month: Int32
    var day: Int32
    var hour: Int32
    var minute: Int32
    var second: Int32

    @staticmethod
    fn from_instant_utc(instant: Instant) -> Self:
        let ts = _CTimeSpec(instant.seconds, instant.nanos)
        let tm = ts_to_utc_tm(ts)

        return DateTimeLocal._from_tm(tm)

    @staticmethod
    fn from_instant(instant: Instant) -> Self:
        let ts = _CTimeSpec(instant.seconds, instant.nanos)
        let tm = ts_to_local_tm(ts)

        return DateTimeLocal._from_tm(tm)

    @staticmethod
    fn _from_tm(tm: C_tm) -> Self:
        return DateTimeLocal(
            tm.tm_year + 1900,
            tm.tm_mon + 1,
            tm.tm_mday,
            tm.tm_hour,
            tm.tm_min,
            tm.tm_sec,
        )

    @staticmethod
    fn now_utc() -> Self:
        return DateTimeLocal.from_instant_utc(Instant.now())

    @staticmethod
    fn now() -> Self:
        return DateTimeLocal.from_instant(Instant.now())

    fn plus_years(self, years: Int32) -> Self:
        return DateTimeLocal(
            self.year + years,
            self.month,
            self.day,
            self.hour,
            self.minute,
            self.second,
        )

    fn plus_months(self, months: Int32) -> Self:
        let new_year = self.year + (months / 12)
        let new_month = ((self.month - 1 + months) % 12) + 1
        return DateTimeLocal(
            new_year,
            new_month,
            self.day,
            self.hour,
            self.minute,
            self.second,
        )

    fn plus_days(self, days: Int32) -> Self:
        """Broken."""
        var new_day = days + self.day
        var new_month = self.month
        var new_year = self.year

        var days_in_current_month = days_in_month(
            new_year.__int__(), new_month.__int__()
        )

        while new_day > days_in_current_month:
            new_day -= days_in_current_month
            new_year += UInt8(new_month == 12).to_int()
            new_month = (new_month % 12) + 1
            days_in_current_month = days_in_month(
                new_year.__int__(), new_month.__int__()
            )

        return DateTimeLocal(
            new_year,
            new_month,
            new_day,
            self.hour,
            self.minute,
            self.second,
        )

    fn plus_hours(self, hours: Int32) -> Self:
        let new_hour = (self.hour + hours) % 24

        let overflow_days = hours / 24

        return DateTimeLocal(
            self.year,
            self.month,
            self.day,
            new_hour,
            self.minute,
            self.second,
        ).plus_days(overflow_days)

    fn plus_minutes(self, minutes: Int32) -> Self:
        let new_minute = (self.minute + minutes) % 60
        let overflow_hours = minutes / 60
        return DateTimeLocal(
            self.year,
            self.month,
            self.day,
            self.hour,
            new_minute,
            self.second,
        ).plus_hours(overflow_hours)

    fn plus_seconds(self, seconds: Int32) -> Self:
        let new_second = (self.second + seconds) % 60
        let overflow_minutes = seconds / 60
        return DateTimeLocal(
            self.year,
            self.month,
            self.day,
            self.hour,
            self.minute,
            new_second,
        ).plus_minutes(overflow_minutes)

    fn __str__(self) -> String:
        # TODO use strftime
        return (
            String(self.year.to_int())
            + "-"
            + ("0" if self.month < 10 else "")
            + String(self.month.to_int())
            + "-"
            + ("0" if self.day < 10 else "")
            + String(self.day.to_int())
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

    fn __repr__(self) -> String:
        return self.__str__()
