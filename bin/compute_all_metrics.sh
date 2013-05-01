#!/bin/env bash
BINDIR=`dirname $0`
INPUTDIR=$1
OUTPUTDIR=$2

METRICS="soccer old_wmt_official new_wmt_official expected_wins expected_net_wins mfas_raw_diff mfas_max_net_wins"
for METRIC in $METRICS; do
  echo; echo METRIC $METRIC
  METRICDIR=$OUTPUTDIR/ranking_$METRIC
  mkdir -p $METRICDIR
  for X in `ls $INPUTDIR`; do echo $X; cat $INPUTDIR/$X | $BINDIR/$METRIC.sh > $METRICDIR/$X; done
done
