from utils.list import VariadicList

alias _DAYS_IN_MONTH = VariadicList[Int](31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)


@always_inline
fn is_leap_year(year: Int) -> Bool:
    return (year % 4 == 0) and ((year % 100 != 0) or (year % 400 == 0))


fn days_in_month(year: Int, month: Int) -> Int:
    # TODO branchless bool to int conversion
    let should_add_leap_day = month == 2 and is_leap_year(year)
    let leap_day_addition = UInt8(should_add_leap_day).to_int()
    return _DAYS_IN_MONTH[month - 1] + leap_day_addition


@value
struct Duration:
    var seconds: Int32
    var minutes: Int32
    var hours: Int32
    var days: Int32
    var months: Int32
    var years: Int32
