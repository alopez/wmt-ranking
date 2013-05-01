#!/usr/bin/env bash
PROJECTDIR=`dirname $0`
OUTPUTDIR=$PROJECTDIR/simulations
BINDIR=$PROJECTDIR/bin

echo Generating simulations ...
SIMDIR=$OUTPUTDIR/simulation_data
mkdir -p $SIMDIR
for T in {1..100}; do 
  for K in {500..10000..500}; do
    $BINDIR/generate_simulation.py -k $K > $SIMDIR/sim.with-ties.trial$T.samples$K
    $BINDIR/generate_simulation.py -nk $K > $SIMDIR/sim.noties.trial$T.samples$K
    $BINDIR/generate_simulation.py -rk $K > $SIMDIR/sim.random-ties.trial$T.samples$K
  done
done

echo Extracting truth...
TRUTHDIR=$OUTPUTDIR/ranking_truth
mkdir -p $TRUTHDIR
for X in `ls $SIMDIR`; do 
  head -1 $SIMDIR/$X | perl -pe 'while (/ (system_\d+) /g){ print "$1\n"; }' | grep -v truth > $TRUTHDIR/$X
done

echo Extracting pairwise statisitics from simulations ...
PAIRWISE=$OUTPUTDIR/pairwise
mkdir -p $PAIRWISE
for X in `ls $SIMDIR`; do 
  cat $SIMDIR/$X | awk '(NF==4){print}' | cut -f -3 -d \ | sort | uniq -c | $BINDIR/collect_stats.py > $PAIRWISE/$X; 
done

$BINDIR/compute_all_metrics.sh $PAIRWISE $OUTPUTDIR

for X in `ls $SIMDIR`; do 
  for R in `ls -d $OUTPUTDIR/ranking* | grep -v truth`; do
    echo Spearman\'s Rho `echo $R | cut -f 3 -d \/` $X `$BINDIR/spearman.py $TRUTHDIR/$X $R/$X`
    echo Pairwise Error  `echo $R | cut -f 3 -d \/` $X `$BINDIR/pairwise-error.py $TRUTHDIR/$X $R/$X`
    echo 1-best rate `echo $R | cut -f 3 -d \/` $X `$BINDIR/onebest.py $TRUTHDIR/$X $R/$X`
  done
done

