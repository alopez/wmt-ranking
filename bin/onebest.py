#!/usr/bin/env python
import optparse
import sys
import math

optparser = optparse.OptionParser()
(opts, args) = optparser.parse_args()

data0 = [line.split()[0] for line in open(args[0])]
data1 = [line.split()[0] for line in open(args[1])]

if data0[0] == data1[0]:
  print "1"
else:
  print "0"
