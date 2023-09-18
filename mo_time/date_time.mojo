from mo_time.ctypes import ts_to_tm, _CTimeSpec, C_tm
from mo_time.duration import Duration


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
    var day_of_week: Int32
    var day_of_year: Int32
    var is_daylight_savings: Bool
    var _c_tm: C_tm

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
            tm.tm_wday,
            tm.tm_yday,
            not tm.tm_isdst.__bool__(),
            tm,
        )

    fn adjust(self, offset: Duration) -> Self:
        print("checkpoint 1")
        var new_tm = C_tm(
            self._c_tm.tm_sec + offset.seconds,
            self._c_tm.tm_min + offset.minutes,
            self._c_tm.tm_hour + offset.hours,
            self._c_tm.tm_mday + offset.days,
            self._c_tm.tm_mon + offset.months - 1,
            self._c_tm.tm_year + offset.years - 1900,
            self._c_tm.tm_wday,
            self._c_tm.tm_yday,
            self._c_tm.tm_isdst,
        )

        print("checkpoint 2")
        let normalized_time_t = external_call["mktime", Int, Pointer[C_tm]](
            Pointer[C_tm].address_of(new_tm)
        )
        print(normalized_time_t)
        print("checkpoint 3")
        let ts = _CTimeSpec(normalized_time_t, 0)
        let normalized_tm = ts_to_tm(ts)
        return Self._from_tm(normalized_tm)

    fn __str__(self) -> String:
        # TODO use strftime
        return (
            String(self.year.to_int())
            + "-"
            + String(self.month.to_int())
            + "-"
            + String(self.day_of_month.to_int())
            + "T"
            + String(self.hour.to_int())
            + ":"
            + String(self.minute.to_int())
            + ":"
            + String(self.second.to_int())
        )
