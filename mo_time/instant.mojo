from mo_time.ctypes import clock_gettime


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
        let ts = clock_gettime()
        return Instant(ts.tv_sec, ts.tv_nsec)
