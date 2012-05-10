#!/usr/bin/env bash

# extract pairwise judgements from WMT10 and WMT11 csv files
echo Extracting pairwise judgements ...
mkdir -p data/pairwise
for X in `cat raw_data/wmt11/wmt11-maneval-indivsystems.RNK_results.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt11 indiv $X; grep $X raw_data/wmt11/wmt11-maneval-indivsystems.RNK_results.csv | bin/extract-pairwise-wmt11.py > data/pairwise/wmt11.$X.individual; done
for X in `cat raw_data/wmt11/wmt11-maneval-combosystems.RNK_results.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt11 combo $X; grep $X raw_data/wmt11/wmt11-maneval-combosystems.RNK_results.csv | bin/extract-pairwise-wmt11.py > data/pairwise/wmt11.$X.combo; done
for X in `cat raw_data/wmt11/wmt11-maneval-tunablemetrics.RNK_results.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt11 tunable $X; grep $X raw_data/wmt11/wmt11-maneval-tunablemetrics.RNK_results.csv | bin/extract-pairwise-wmt11.py > data/pairwise/wmt11.$X.tunablemetrics; done
for X in `cat raw_data/wmt10/data_RNK.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt10 $X; grep $X raw_data/wmt10/data_RNK.csv| bin/extract-pairwise-wmt11.py > data/pairwise/wmt10.$X; done
for X in `cat raw_data/wmt12/wmt12.RNK_results.csv | grep -v srclang | cut -f -2 -d , | sort | uniq`; do echo wmt12 $X; grep $X raw_data/wmt12/wmt12.RNK_results.csv| bin/extract-pairwise-wmt11.py > data/pairwise/wmt12.$X; done

# calculate ranking from >=/>=< votes with ref (EQ 1 -- WMT official)
echo; echo Calculating WMT official rankings ...
mkdir -p data/denom_wmt_official
mkdir -p data/ranking_wmt_official
for X in `ls data/pairwise`; do cat data/pairwise/$X | awk '{print $1}' | sort | uniq -c > data/denom_wmt_official/$X; done
for X in `ls data/pairwise`; do echo $X; cat data/pairwise/$X | awk '($3!="<"){print $1}' | sort | uniq -c | paste - data/denom_wmt_official/$X | awk '{print $2"\t"$1/$3*100}' | sort -nrk 2 > data/ranking_wmt_official/$X; done

# calculate ranking from >/>=< votes without ref (EQ 2 -- Bojar recommendation)
echo; echo Calculating Bojar metric rankings ...
mkdir -p data/denom_bojar
mkdir -p data/ranking_bojar
for X in `ls data/pairwise`; do cat data/pairwise/$X | grep -v _ref | grep -v = | awk '{print $1}' | sort | uniq -c > data/denom_bojar/$X; done
for X in `ls data/pairwise`; do echo $X; cat data/pairwise/$X | grep -v _ref | grep -v = | awk '($3==">"){print $1}' | sort | uniq -c | paste - data/denom_bojar/$X | awk '{print $2"\t"$1/$3*100}' | sort -nrk 2 > data/ranking_bojar/$X; done

# calculate ranking from >/>=< votes without ref (EQ 2 -- Bojar variant)
echo; echo Calculating heuristic 2 metric rankings ...
mkdir -p data/denom_heuristic2
mkdir -p data/ranking_heuristic2
for X in `ls data/pairwise`; do cat data/pairwise/$X | grep -v _ref | awk '{print $1}' | sort | uniq -c > data/denom_heuristic2/$X; done
for X in `ls data/pairwise`; do echo $X; cat data/pairwise/$X | grep -v _ref | awk '($3==">"){print $1}' | sort | uniq -c | paste - data/denom_heuristic2/$X | awk '{print $2"\t"$1/$3*100}' | sort -nrk 2 > data/ranking_heuristic2/$X; done

# calculate ranking with minimum feedback arc set
echo; echo Calculating MFAS rankings ...
mkdir -p data/tournaments
mkdir -p data/ranking_mfas
for X in `ls data/pairwise`; do cat data/pairwise/$X | grep -v = | sort | uniq -c > data/tournaments/$X; done
for X in `ls data/pairwise`; do echo $X; cat data/tournaments/$X | bin/mfas_solver.py > data/ranking_mfas/$X; done

echo Total FAS weight of WMT Official ranking:
for X in `ls data/pairwise/`; do bin/fas_cost.py data/tournaments/$X < data/ranking_wmt_official/$X; done | awk '(NF==1){print}' | awk 'BEGIN {S=0}; {S=S+$1}; END {print S}'
echo Total FAS weight of Bojar ranking:
for X in `ls data/pairwise/`; do bin/fas_cost.py data/tournaments/$X < data/ranking_bojar/$X; done | awk '(NF==1){print}' | awk 'BEGIN {S=0}; {S=S+$1}; END {print S}'
echo Total FAS weight of Heuristic 2 ranking:
for X in `ls data/pairwise/`; do bin/fas_cost.py data/tournaments/$X < data/ranking_heuristic2/$X; done | awk '(NF==1){print}' | awk 'BEGIN {S=0}; {S=S+$1}; END {print S}'
echo Total FAS weight of MFAS ranking:
for X in `ls data/pairwise/`; do bin/fas_cost.py data/tournaments/$X < data/ranking_mfas/$X; done | awk '(NF==1){print}' | awk 'BEGIN {S=0}; {S=S+$1}; END {print S}'

