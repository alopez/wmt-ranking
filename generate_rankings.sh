#!/usr/bin/env bash
PROJECTDIR=`dirname $0`
INPUTDIR=$PROJECTDIR/raw_data
OUTPUTDIR=$PROJECTDIR/data
BINDIR=$PROJECTDIR/bin

# extract pairwise judgements from WMT10 and WMT11 csv files
echo Extracting pairwise judgements ...
PAIRWISE=$OUTPUTDIR/pairwise
mkdir -p $PAIRWISE
for X in `cat $INPUTDIR/wmt11/wmt11-maneval-indivsystems.RNK_results.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt11 indiv $X; grep $X $INPUTDIR/wmt11/wmt11-maneval-indivsystems.RNK_results.csv | $BINDIR/extract-pairwise-wmt11.py | sort | uniq -c | bin/collect_stats.py | sort > $PAIRWISE/wmt11.$X.individual; done
for X in `cat $INPUTDIR/wmt11/wmt11-maneval-combosystems.RNK_results.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt11 combo $X; grep $X $INPUTDIR/wmt11/wmt11-maneval-combosystems.RNK_results.csv | $BINDIR/extract-pairwise-wmt11.py | sort | uniq -c | bin/collect_stats.py | sort > $PAIRWISE/wmt11.$X.combo; done
for X in `cat $INPUTDIR/wmt11/wmt11-maneval-tunablemetrics.RNK_results.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt11 tunable $X; grep $X $INPUTDIR/wmt11/wmt11-maneval-tunablemetrics.RNK_results.csv | $BINDIR/extract-pairwise-wmt11.py | sort | uniq -c | bin/collect_stats.py | sort > $PAIRWISE/wmt11.$X.tunablemetrics; done
for X in `cat $INPUTDIR/wmt10/data_RNK.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt10 $X; grep $X $INPUTDIR/wmt10/data_RNK.csv| $BINDIR/extract-pairwise-wmt11.py | sort | uniq -c | bin/collect_stats.py | sort > $PAIRWISE/wmt10.$X; done
for X in `cat $INPUTDIR/wmt12/wmt12.RNK_results.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt12 $X; grep $X $INPUTDIR/wmt12/wmt12.RNK_results.csv| $BINDIR/extract-pairwise-wmt11.py | sort | uniq -c | bin/collect_stats.py | sort > $PAIRWISE/wmt12.$X; done

$BINDIR/compute_all_metrics.sh $PAIRWISE $OUTPUTDIR

