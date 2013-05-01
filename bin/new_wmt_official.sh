#!/bin/env bash
BINDIR=`dirname $0`
grep -v _ref | $BINDIR/bojar_ratio.py
