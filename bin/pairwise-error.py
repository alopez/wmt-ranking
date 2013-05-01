#!/usr/bin/env python
import optparse
import sys
from itertools import combinations

optparser = optparse.OptionParser()
(opts, args) = optparser.parse_args()

data0 = [line.split()[0] for line in open(args[0])]
data1 = [line.split()[0] for line in open(args[1])]

if set(data0) != set(data1):
  sys.stderr.write("Files %s and %s do not contain the same set of objects" % (args[0], args[1]))
  sys.exit(1)

pairs0 = set((data0[i],data0[j]) for i,j in combinations(range(len(data0)),2) if i<j)
pairs1 = set((data1[i],data1[j]) for i,j in combinations(range(len(data1)),2) if i<j)

print  1 - float(len(pairs0 & pairs1))/len(pairs0)

