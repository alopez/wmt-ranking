#!/usr/bin/env python
import optparse
import sys
import math

optparser = optparse.OptionParser()
(opts, args) = optparser.parse_args()

data0 = [line.split()[0] for line in open(args[0])]
data1 = [line.split()[0] for line in open(args[1])]

ranking0 = dict([(x,i) for (i,x) in enumerate([s for s in data0 if s in (set(data0) & set(data1))])])
ranking1 = dict([(x,i) for (i,x) in enumerate([s for s in data1 if s in (set(data0) & set(data1))])])

n = len(ranking0)  
print 1 - (6*sum([math.pow(int(ranking0[system])-int(ranking1[system]),2.0) for system in ranking1]))/(n * (n*n-1))
