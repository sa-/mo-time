from mo_time import Instant, DateTimeLocal, Duration


# These are tests, I am not recommending that we add these in 😁
def main():
    let now = Instant.now()
    let dt = DateTimeLocal.from_instant(now)
    print(dt.__str__())
    let duration = Duration(0, 0, 0, 365, 0, 0)
    let new_dt = dt.adjust(duration)
    print(new_dt.__str__())
