## Usage

```mojo
let now = Instant.utc_now()
let dt = DateTimeLocal.from_instant(now)
```

Coming up
- Types
  - `ZonedDateTime`
  - `Date`
  - `Time`
  - `Duration`
  - `TimeZone`


## Testing 

`mojo run test.mojo`

```
second:  6
minute:  17
hour:  7
day_of_month:  14
month:  9
year:  2023
weekday:  4
day_of_year:  256
is_daylight_savings:  False
```