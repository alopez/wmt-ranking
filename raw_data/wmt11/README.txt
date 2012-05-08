Those files contain the judgments for the ranking task of WMT '11.  Each row
corresponds to ranking a set of five outputs from five systems over some source
segment.  Here is a bit about what each column contains:

(*) srclang and trglang: source language and target language
(*) srcIndex: the order of the source segment in the plain test set file.
    This order is 1-based, NOT 0-based.
(*) documentId and segmentId: a document and segment ID of the source segment.
    These two columns can be ignored, as they are redundant with the previous
    columns (and are remnants from last year's evaluation).
(*) judgeId: the anonymous ID assigned by Amazon Mechanical Turk to the
    annotator completing this block.
(*) system1Number,..., system5Number: the anonymous number assigned to the
    system producing the first,...,fifth output shown to the annotator.
(*) system1Id,...,system5Id: the name of the system producing the first,...,fifth
    output shown to the annotator.  Note that there is a one-to-one mapping from
    systemNumber to systemId.
(*) system1rank,...,system5rank: the rank label (between 1 and 5) assigned by
    the annotator to the output of the first,...,fifth system.  A lower rank
    value indicates better output, and ties are allowed.  A value of -1 indicates
    the rank label was left blank.


