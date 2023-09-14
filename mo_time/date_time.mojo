from mo_time.ctypes import ts_to_tm, _CTimeSpec


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

    @staticmethod
    fn from_instant(instant: Instant) -> Self:
        let ts = _CTimeSpec(instant.seconds, instant.nanos)
        let tm = ts_to_tm(ts)

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
        )

    fn __str__(self) -> StringLiteral:
        """Format using ISO 8601"""
        # TODO
        return "TODO: implement when string formatting exists"
