Status: Experimental. 

Please don't put negative numbers in `plus_*` functions 😬

## Usage

Download the package from `dist/mo_time.mojopkg`

```python
let now = Instant.now()
let dt = DateTimeLocal.now_utc()
let dt2 = DateTimeLocal.from_instant(now)
let dt3 = DateTimeLocal(2023, 9, 14, 0, 0, 0)

dt2.plus_years(1)
dt2.plus_months(12)
dt2.plus_days(366)
dt2.plus_hours(8784)
dt2.plus_minutes(527040)
dt2.plus_seconds(31622400)
```

Coming up
- Types
  - `DateTimeZoned`
  - `Date`
  - `Time`
  - `Duration`
  - `TimeZone`


## Testing 

`make test`
