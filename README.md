Status: Experimental. 

Please don't put negative numbers in `plus_*` functions yet 😬

## Usage

Download the package from `dist/mo_time.mojopkg`

```python
# Instantiate with the .now static methods
DateTimeLocal.now_utc()
DateTimeLocal.now()

# or from an Instant
let instant = Instant.now()
DateTimeLocal.from_instant(instant)
DateTimeLocal.from_instant_utc(instant)

# or with the constructor
DateTimeLocal(2023, 9, 14, 0, 0, 0)

# Print
let dt = DateTimeLocal.now_utc()
print(dt.__str__())

# Supports basic arithmetic
dt.plus_years(1)
dt.plus_months(12)
dt.plus_days(366)
dt.plus_hours(8784)
dt.plus_minutes(527040)
dt.plus_seconds(31622400)
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
