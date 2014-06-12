Nonterminals
    grammar quotation.

Terminals
    number atom word.

Rootsymbol grammar.


grammar -> quotation : '$1'.
quotation -> number quotation : [rotate('$1')|'$2'].
quotation -> atom quotation : [rotate('$1')|'$2'].
quotation -> word quotation : [rotate('$1')|'$2'].
quotation -> word   : [rotate('$1')].
quotation -> atom   : [rotate('$1')].
quotation -> number : [rotate('$1')].


Erlang code.

%%rotate({T, L, V}) -> {V, T, L}.
rotate({T, L, V}) -> V.
