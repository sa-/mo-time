from utils.list import VariadicList

alias _DAYS_IN_MONTH = VariadicList[Int](31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)


fn is_leap_year(year: Int) -> Bool:
    return (year % 4 == 0) and ((year % 100 != 0) or (year % 400 == 0))


fn days_in_month(year: Int, month: Int) -> Int:
    # TODO branchless bool to int conversion
    let add_leap_day = 1 if (month == 2 and is_leap_year(year)) else 0
    return _DAYS_IN_MONTH[month - 1] + add_leap_day


@value
struct Duration:
    var seconds: Int32
    var minutes: Int32
    var hours: Int32
    var days: Int32
    var months: Int32
    var years: Int32
