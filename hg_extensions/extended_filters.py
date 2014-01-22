import datetime
from mercurial import templatefilters

def rpad(s, width, pad_char=' '):
  if len(s) < width:
    return "%s%s" % (s, pad_char * (width - len(s)))
  return s

def lpad(s, width, pad_char=' '):
  if len(s) < width:
    return "%s%s" % (pad_char * (width - len(s)), s)
  return s

def day_of_week(date):
  """filter a mercurial date down to the integer day of the week
  Monday is 0
  Sunday is 6
  """
  timestamp, offset = date
  class TZ(datetime.tzinfo):
    def utcoffset(self, dt):
      return datetime.timedelta(seconds=offset)
    def dst(self, dt):
      return datetime.timedelta(0)

  dt = datetime.datetime.fromtimestamp(timestamp, TZ())
  return dt.weekday()

def extsetup(ui):
  templatefilters.filters['rpad10'] = lambda s: rpad(s, 10)
  templatefilters.filters['lpad10'] = lambda s: lpad(s, 10)
  templatefilters.filters['dow'] = day_of_week
