The judgments for the ranking task are in data_RNK.csv.  Each row corresponds to ranking a set of five outputs from five systems on the same source segment.

(*) srclang and trglang: source language and target language
(*) srcIndex: the order of the source segment in the plain test set file.  This order is 1-based, not 0-based.
(*) documentId and segmentId: the document and segment ID's of the source segment, as identified in the XML-formatted files.  Note that there is a one-to-one mapping from srcIndex to (docid,segid).
(*) judgeId: the anonymous ID assigned by Amazon Mechanical Turk to the annotator completing this task.
(*) system1Number,..., system5Number: the anonymous number assigned to the system producing the first,...,fifth output shown to the annotator.
(*) system1Id,...,system5Id: the name of the system producing the first,...,fifth output shown to the annotator.  Note that there is a one-to-one mapping from systemNumber to systemId.
(*) system1rank,...,system5rank: the rank (between 1 and 5) assigned by the annotator to the output of the first,...,fifth system.  A lower rank value indicates better output, and ties are allowed.  A value of -1 indicates the rank was left blank.

The judgments in data_RNK-public.csv correspond to the judgments collected from general workers on Mechanical Turk.  The format is similar to that of data_RNK.csv.



The edits collected in the editing task are in data_EDT.tsv.  Note that the entries are tab-separated, rather than comma-separated.  Each row corresponds to editing a single output.

(*) editId: a unique identifier given to an edit.  This ID is referenced in the acceptability task below.
(*) srclang,...,systemId: same meaning as above.
(*) system1actionVal and system1actionStr: an indication of what the editor chose to do.  The values 1 and EDIT indicate the editor provided an edit of the output.  The values 2 and OK indicate the editor decided no editing is required.  The values 3 and BAD indicate the editor found the translation too bad to correct.
(*) system1edit: the edit provided by the editor.  If the editor performed no editing (either because the output was deemed acceptable or too disfluent to correct) then the original output is provided.



The judgments collected in the acceptability task are in data_ACC.csv.  Each row corresponds to a judgment on an edit from the previous task.

(*) srclang,...,systemId: same meaning as above.
(*) editId: the unique identifier associated with the edit being judged.  This ID can be used to obtain the actual (edited) sentence being judged by searching for it in data_EDT.tsv.
(*) judgment: YES, NO, or UNK.  "YES" indicates the edit was judged to be acceptable; "NO" indicates the edit was judged to be unacceptable; "UNK" indicates no judgment was provided for this edit.
