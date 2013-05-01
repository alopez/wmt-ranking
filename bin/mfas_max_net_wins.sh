#!/bin/env bash
BINDIR=`dirname $0`
grep -v _ref | awk '($3>$5){print $1" "$2" "2*($3-$5)/($3+$4+$5)}' | $BINDIR/mfas_solver.py
