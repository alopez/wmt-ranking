#!/usr/bin/python
import sys
from collections import defaultdict
from collections import namedtuple

# Utility functions
def bitmap(sequence):
  """ Generate a coverage bitmap for a sequence of indexes """
  return reduce(lambda x,y: x|y, [long('1'+'0'*i,2) for i in sequence], 0)

def bitmap2str(b, n, on='o', off='.'):
  """ Generate a length-n string representation of bitmap b """
  return '' if n==0 else (on if b&1==1 else off) + bitmap2str(b>>1, n-1, on, off)

def indexes(b, n=0):
  """ Generate a list of indexes that are turned on in a bitmap b """
  return [] if b==0 else ([n] if b&1==1 else []) + indexes(b>>1, n+1)

pairwise_score = defaultdict(int)
vertices = set()
for line in open(sys.argv[1]):
  (count, sys1, sys2, order) = line.strip().split()
  pairwise_score[(sys1,sys2)] += int(count) if order == "<" else -int(count)
  vertices.add(sys1)
  vertices.add(sys2)

tournament = defaultdict(dict)
for (u, v), weight in pairwise_score.iteritems():
  if weight < 0:
    tournament[u][v] = weight 

discrepancy = 0
ranked = set()
for line in sys.stdin:
  system = line.strip().split()[0]
  for prev_system in ranked:
    if prev_system in tournament[system]:
      discrepancy += tournament[system][prev_system]
      print system, prev_system, tournament[system][prev_system]
  ranked.add(system)
print discrepancy

