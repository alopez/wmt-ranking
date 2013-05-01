#!/bin/env python
import sys
from collections import defaultdict

stats = defaultdict(lambda: defaultdict(float))
for line in sys.stdin:
  (sys1, sys2, sys1better, equal, sys2better) = line.strip().split()
  stats[sys1][">"] += int(sys1better)
  stats[sys1]["="] += int(equal)
  stats[sys1]["<"] += int(sys2better)

scores = [(s, 100*(x[">"])/(x[">"]+x["<"])) for s, x in stats.iteritems()]

for sys, score in sorted(scores, key=lambda pair: -pair[1]):
  print "%s\t%2.6g" % (sys, score)
  
  


