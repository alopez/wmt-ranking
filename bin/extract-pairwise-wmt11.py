#!/usr/bin/python
import sys
from itertools import combinations

for line in sys.stdin:
  fields = line.strip().split(",")
  ranks = [(fields[i],int(fields[j])) for i,j in zip(xrange(7,16,2), xrange(16,21)) if fields[j] != "-1"]
  if len(ranks) > 1: # we can hardly rank unless we have at least two items!
    for ((sys1, rank1), (sys2, rank2)) in (sorted(c, key=lambda x:x[0]) for c in combinations(ranks, 2)):
      result = ("<",">") if rank1 > rank2 else (">","<") if rank1 < rank2 else ("=","=")
      print sys1, sys2, result[0]
      print sys2, sys1, result[1]
