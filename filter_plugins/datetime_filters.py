import datetime


def filter_to_utc(v: datetime.datetime):
    t_local = v.astimezone()
    offset = t_local.utcoffset()
    
    t_utc = (t_local - offset).replace(tzinfo=datetime.timezone.utc)

    return t_utc


class FilterModule:
    def filters(self):
        return {
            'to_utc': filter_to_utc,
        }