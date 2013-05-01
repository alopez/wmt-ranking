#!/usr/bin/env python
import sys
import math
import random
import itertools

num_systems = 15
num_samples = 10
tie_rate = 0.18
systems = range(num_systems)
quality = [random.random() for i in systems]

print [(x,y) for x,y in zip(systems, quality)]
for _ in xrange(num_samples):
  ballot = random.sample(systems, 5)
  result = [random.gauss(quality[sys], math.sqrt(10)) for sys in ballot]
  ranking = []
  next_rank = []
  for pair in sorted([(x,y) for x,y in zip(ballot, result)], key=lambda p: -p[1]):
    next_rank.append(pair[0])
    if random.random() > tie_rate:
      ranking.append(next_rank)
      next_rank = []
  if next_rank:
    ranking.append(next_rank)
  print ranking
  for systems, rank in enumerate(ranking):
    for sys1, sys2 in itertools.chain(systems):
      print "%s %s =" % (sys1, sys2)
    for sys1 in systems:
      for sys2 in itertools.chain(*(ranking[rank+1:])):
        print "%s %s >" % (sys1, sys2)

