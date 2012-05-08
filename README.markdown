Data and Code for Ranking Machine Translation Systems from Human Assessments
============================================================================

This directory contains code and data used to generate different rankings of
machine translation systems from human assessment data, as described in:

[Adam Lopez. Putting Human Assessments of Machine Translation Systems in Order. 
Proceedings of the Workshop on Statistical Machine Translation (WMT) 2012.
](http://www.cs.jhu.edu/~alopez/papers/wmt2012-alopez.pdf)

The data are derived from several past editions of the [Workshop on Machine 
Translation](http://www.statmt.org/wmt12) organized by the [ACL Special Interest Group on Machine Translation](http://www.sigmt.org/).
Note that only data from the 2010 and 2011 editions were used for the paper,
although data from the last five workshops are included.

Ranking the Systems
-------------------

Run the command generate_rankings.sh. This will extract pairwise comparisons
from the raw data and run the various ranking algorithms. Most of the code
is either in simple bash or python scripts.

Directory structure
-------------------

* **raw_data** contains the raw assessment data from five incarnations of
  the workshop, obtained from these public URLs:
  * <http://www.statmt.org/wmt11/manual-eval-judgments.zip>
  * <http://www.statmt.org/wmt10/results/manual-eval-judgments.zip>
  * <http://www.statmt.org/wmt09/wmt09-human-judgments.csv.gz>
  * <http://www.statmt.org/wmt08/wmt08-human-judgments.csv.gz>
  * <http://www.statmt.org/wmt07/judgements.gz>

* **bin** contains utility scripts in python and bash to extract pairwise
  rankings from the raw data, compute rankings from tournaments, compute 
  the cost of a feedback arc sets, and compute Spearman's rho.

* **data** contains rankings and intermediate data produced by the scripts.
  This directory is produced by the top-level script generate_rankings.sh




