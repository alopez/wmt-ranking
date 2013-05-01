#!/bin/env bash
BINDIR=`dirname $0`
grep -v _ref | $BINDIR/expected_wins.py
