#!/usr/bin/python
import sys
from collections import defaultdict

summary = defaultdict(lambda: defaultdict(int))
for line in sys.stdin:
  (count, sys1, sys2, result) = line.strip().split()
  summary[(sys1, sys2)][result] = count

for pair in summary:
  print " ".join(pair + tuple(str(summary[pair][op]) for op in [">", "=", "<"]))
