alias _CLOCK_REALTIME = 0


from memory.unsafe import Pointer


@value
@register_passable("trivial")
struct _CTimeSpec:
    var tv_sec: Int  # Seconds
    var tv_nsec: Int  # NanoSeconds

    fn __init__() -> Self:
        return Self {tv_sec: 0, tv_nsec: 0}

    fn as_nanoseconds(self) -> Int:
        return self.tv_sec * 1_000_000_000 + self.tv_nsec


@always_inline
fn _clock_gettime() -> _CTimeSpec:
    """Low-level call to the clock_gettime libc function"""
    var ts = _CTimeSpec()
    let ts_pointer = Pointer[_CTimeSpec].address_of(ts)

    let clockid_si32: Int32 = _CLOCK_REALTIME

    external_call["clock_gettime", NoneType, Int32, Pointer[_CTimeSpec]](
        clockid_si32, ts_pointer
    )

    return ts


## new code starts here


@value
@register_passable("trivial")
struct C_tm:
    var tm_sec: Int32
    var tm_min: Int32
    var tm_hour: Int32
    var tm_mday: Int32
    var tm_mon: Int32
    var tm_year: Int32
    var tm_wday: Int32
    var tm_yday: Int32
    var tm_isdst: Int32

    fn __init__() -> Self:
        return Self {
            tm_sec: 0,
            tm_min: 0,
            tm_hour: 0,
            tm_mday: 0,
            tm_mon: 0,
            tm_year: 0,
            tm_wday: 0,
            tm_yday: 0,
            tm_isdst: 0,
        }


@always_inline
fn _ts_to_tm(owned ts: _CTimeSpec) -> C_tm:
    let ts_pointer = Pointer[Int].address_of(ts.tv_sec)

    # Call libc's clock_gettime.
    let tm = external_call["gmtime", Pointer[C_tm], Pointer[Int]](ts_pointer).load()
    return tm


@value
struct Instant:
    """Seconds since epoch."""

    var seconds: Int
    """Nanos since second."""
    var nanos: Int

    fn __init__(inout self):
        self.seconds = 0
        self.nanos = 0

    @staticmethod
    fn utc_now() -> Self:
        let ts = _clock_gettime()
        return Instant(ts.tv_sec, ts.tv_nsec)


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
        let tm = _ts_to_tm(ts)

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
        return "TODO: implement when string formatting exists"
