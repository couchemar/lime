Nonterminals
    grammar quotation.

Terminals
    number atom word.

Rootsymbol grammar.


grammar -> quotation : '$1'.
quotation -> number quotation : ['$1'|'$2'].
quotation -> atom quotation : ['$1'|'$2'].
quotation -> word quotation : ['$1'|'$2'].
quotation -> word   : ['$1'].
quotation -> atom   : ['$1'].
quotation -> number : ['$1'].


Erlang code.

line({_, L}) -> L;
line({_, L, _}) -> L.

unwrap({V, _}) -> V;
unwrap({_, _, V}) -> V.