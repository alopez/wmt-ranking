#!/bin/env python
import sys
import math
import random
import itertools
import optparse

optparser = optparse.OptionParser()
optparser.add_option("-s", "--systems", dest="num_systems", default=15, type="int", help="Number of systems")
optparser.add_option("-k", "--samples", dest="num_samples", default=10000, type="int", help="Number of samples")
optparser.add_option("-n", "--no-ties", action="store_true", dest="no_ties", default=False, help="Do not model ties")
optparser.add_option("-r", "--random-ties", action="store_true", dest="random_ties", default=False, help="Do not make ties depend on systems")
optparser.add_option("-v", "--tie-point-variance", dest="tie_point_var", default=1.0, type="float", help="Tie rate variance")
optparser.add_option("-t", "--tie-point-mean", dest="tie_point_mean", default=3.0, type="float", help="Tie rate mean")
#optparser.add_option("-r", "--random-seed", dest="random_seed", default=
(opts, _) = optparser.parse_args()

systems = range(opts.num_systems)
quality = [10*random.random() for i in systems]

def random_tie(quality_diff):
  if opts.no_ties:
    return False
  if opts.random_ties:
    return 0.36 > random.random()
  return quality_diff < random.gauss(opts.tie_point_mean, opts.tie_point_var)

print "truth: ", " ".join(["system_%d (%f)" % (x,y) for x,y in sorted(zip(systems, quality), key=lambda x:-x[1])])
for _ in xrange(opts.num_samples):
  ballot = random.sample(systems, 5)
  qualities = [random.gauss(quality[sys], 10) for sys in ballot]
  order = sorted([(s,q) for s,q in zip(ballot, qualities)], key=lambda pair: -pair[1])
  ranking = []
  next_rank = []
  for i in xrange(len(order)):
    next_rank.append(order[i][0])
    if i+1 == len(order) or not random_tie(order[i][1] - order[i+1][1]):
      ranking.append(next_rank)
      next_rank = []
  for i, rank_i_systems in enumerate(ranking):
    for sys1, sys2 in itertools.product(rank_i_systems, repeat=2):
      if sys1 != sys2:
        diff = qualities[ballot.index(sys1)] - qualities[ballot.index(sys2)]
        print "system_%s system_%s = %f" % (sys1, sys2, diff)
    for sys1 in rank_i_systems:
      for sys2 in itertools.chain(*(ranking[i+1:])):
        diff = qualities[ballot.index(sys1)] - qualities[ballot.index(sys2)]
        print "system_%s system_%s > %f" % (sys1, sys2, diff)
        print "system_%s system_%s < %f" % (sys2, sys1, -diff)

