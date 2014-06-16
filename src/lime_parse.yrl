Nonterminals
    grammar quotation quote.

Terminals
    number atom word quotation_open quotation_close.

Rootsymbol grammar.


grammar -> quotation : '$1'.
quotation -> number quotation : [rotate('$1')|'$2'].
quotation -> atom quotation : [rotate('$1')|'$2'].
quotation -> word quotation : [rotate('$1')|'$2'].
quotation -> word   : [rotate('$1')].
quotation -> atom   : [rotate('$1')].
quotation -> number : [rotate('$1')].
quotation -> quote : ['$1'].
quotation -> quote quotation: ['$1'|'$2'].
quote -> quotation_open quotation quotation_close : '$2'.


Erlang code.

%%rotate({T, L, V}) -> {V, T, L}.
rotate({_T, _L, V}) -> V.
