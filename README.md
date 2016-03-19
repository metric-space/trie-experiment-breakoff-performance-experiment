
### Goal of this experiment

I made a small web application that used a trie gem (rambling-trie) for word-suggestion
and a bk tree for correct word suggestion if the word wasnt found in the trie. I put it
on heroku but alas with the 2 minute app initialisation time I had to change my way of 
simply initiating a new trie object/bk tree object and dumping words into it (It took too long
to initiate it, the insertion of a word with increasing depth starting taking a heavy tool on initation time).

Though by breaking the tree into sub trees I brought the initiation time to less than two minutes,
 I wanted to check how much of a lesser initiation time it took and what else could I do to decrease the 
initiation time further.
