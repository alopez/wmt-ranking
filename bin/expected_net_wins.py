#!/bin/env python
import sys
from collections import defaultdict

sum_term = defaultdict(float)
normalizer = defaultdict(int)
systems = set()
for line in sys.stdin:
  (sys1, sys2) = line.strip().split()[:2]
  (sys1better, equal, sys2better) = (float(x) for x in line.strip().split()[2:])
  sum_term[sys1] += (sys1better - sys2better)/(sys1better + equal + sys2better)
  normalizer[sys1] += 1
  systems.add(sys1)
 
scores = [(s, sum_term[s]/normalizer[s]) for s in systems]

for sys, score in sorted(scores, key=lambda pair: -pair[1]):
  print "%s\t%2.6g" % (sys, score)
  
  


