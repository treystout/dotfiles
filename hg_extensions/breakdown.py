import datetime
from collections import Counter

from mercurial import commands
from mercurial import util
from mercurial import templatefilters

def day_of_week(hg_date):
  """filter a mercurial date down to the integer day of the week
  Monday is 0
  Sunday is 6
  """
  timestamp, offset = hg_date
  class TZ(datetime.tzinfo):
    def utcoffset(self, dt):
      return datetime.timedelta(seconds=offset)
    def dst(self, dt):
      return datetime.timedelta(0)

  dt = datetime.datetime.fromtimestamp(timestamp, TZ())
  return dt.weekday()

def summarize_counter(ui, counter, count=None, msg=None):
  remainder = 0
  if count:
    entries = len(set(counter))
    remainder = entries - count

  ui.write("%s" % msg)
  if remainder and remainder > 0:
    ui.write(" (showing %d of %d)\n" % (count, entries))
  else:
    ui.write("\n")
  ui.write("\n".join(["  {1:>4d}: {0}".format(*pair) for pair in \
      counter.most_common(count)]))
  ui.write("\n")

def walk_back_by_days(ui, repo, days_back):
  date_filter = util.matchdate("-%d" % days_back)

  valid_changes = []
  # walk the change log backwards
  for log_idx in reversed(repo.changelog.index):
    ctx = repo[log_idx[7]]
    if ctx.date()[0] == 0: # some don't have a date, weird...
      continue
    elif date_filter(ctx.date()[0]):
      valid_changes.append(ctx)
    else: # has a date, but it didn't pass the filter, break out of the loop
      break
  return valid_changes

def breakdown(ui, repo, **opts):
  """Breaks down commits over the past `d` days by user, module, or churn

  Things I want to know:
    * which branch has the most commits and churn
    * which author has the most commits and churn
    * which files had the most churn
    * which commits had no ticket
    * table for standup of all commits made to any branch, sorted by author
  """
  ui.note("looking %d days back\n" % opts['days'])
  changes = walk_back_by_days(ui, repo, opts['days'])
  ui.note("found %d changes in range\n" % len(changes))

  counters = {
      'commits_by_author': Counter(),
      'commits_by_branch': Counter(),
      'commits_by_weekday': Counter(),
  }

  for c in changes:
    # update author's commit count
    counters['commits_by_author'][templatefilters.person(c.user())] += 1
    counters['commits_by_branch'][c.branch()] += 1
    counters['commits_by_weekday'][day_of_week(c.date())] += 1
    #for f in repo[c]:
    #  print f
    break

  summarize_counter(ui, counters['commits_by_author'], count=20,
      msg="Commits by Author")
  summarize_counter(ui, counters['commits_by_branch'], count=20,
      msg="Commits by Branch")
  summarize_counter(ui, counters['commits_by_weekday'],
      msg="Commits by Weekday")

cmdtable = {
    'bd': (breakdown, [
      ('d', 'days', 1, 'how many days to look back?')
    ], "hg bd [options]")
}
