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

tournament = defaultdict(lambda: defaultdict(float))
vertices = set()
for line in sys.stdin:
  (u, v, weight) = line.strip().split()
  tournament[u][v] = float(weight)
  vertices.update([u,v])

vertices = list(vertices)
hypothesis = namedtuple("hypothesis", "cost, state, predecessor, vertex")
initial_hypothesis = hypothesis(0, 0, None, None)
agenda = {}
agenda[0] = initial_hypothesis
goal = bitmap(xrange(len(vertices)))

while len(agenda) > 0:
  h = sorted(agenda.itervalues(), key=lambda h: h.cost)[0]
  if h.state == goal:
    break
  del agenda[h.state]
  for u in indexes(goal^h.state):
    new_state = h.state | bitmap([u])
    added_cost = 0
    for v in indexes(goal^new_state):
      if vertices[u] in tournament[vertices[v]]:
        added_cost += tournament[vertices[v]][vertices[u]]
    new_h = hypothesis(h.cost + added_cost, new_state, h, vertices[u])
    if new_state not in agenda or agenda[new_state].cost > new_h.cost:
      agenda[new_state] = new_h

def extract_ranking(h):
  return "" if h.predecessor is None else "%s%s\n" % (extract_ranking(h.predecessor), h.vertex)
sys.stdout.write(extract_ranking(h))
