
### Goal of this experiment

I made a small web application that used a trie gem (rambling-trie) for word-suggestion
and a bk tree for correct word suggestion if the word wasnt found in the trie. I put it
on heroku but alas with the 2 minute app initialisation time I had to change my way of 
simply initiating a new trie object/bk tree object and dumping words into it (It took too long
to initiate it, the insertion of a word with increasing depth starting taking a heavy tool on initation time).

Though by breaking the tree into sub trees I brought the initiation time to less than two minutes,
 I wanted to check how much of a lesser initiation time it took and what else I could do to decrease the 
initiation time further.

So I decided to make three approaches 

1. The first one is what I call the `Naive approach`, which is just dumping the whole
dictionary into both the trie and BK tree data structure.

2. The second one is what I call the `Split approach`, which is splitting up the dictionary by alphabet,
and then creating a hash structure wherein each key (alphabet) maps to a trie / bk tree structure containing
words starting with the alphabet stored as the key.

3. The third one is what I call the `Parallel approach`, which is pretty much the same as the split approach, but instead
of the the mapping done in a sequential mannerx(I am refering to the filling), it is done in parallel.


The averages seem to be as follows

```
+-----------+-------------------+
|        Naive Approach         |
+-----------+-------------------+
| structure | time              |
+-----------+-------------------+
| Trie      | 6.516319290036336 |
| BK        | 50.0839334600023  |
+-----------+-------------------+


+-----------+--------------------+
|         Split Approach         |
+-----------+--------------------+
| structure | time               |
+-----------+--------------------+
| Trie      | 7.020255167968571  |
| BK        | 34.494234380021226 |
+-----------+--------------------+


+-----------+--------------------+
|       Parallel Approach        |
+-----------+--------------------+
| structure | time               |
+-----------+--------------------+
| Trie      | 7.2010546430246904 |
| BK        | 11.336357298016082 |
+-----------+--------------------+

```

### Conclusion

All the approaches for trying to reduce the intitiation time doesn't seem decrease time for the trie structure but does so for the bk structure, but doing the split process in parallel isn't worth the effort in both cases.


 
