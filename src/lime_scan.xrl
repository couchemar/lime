Definitions.

Digit      = [0-9]
UpperCase  = [A-Z]
LowerCase  = [a-z]
Underscore = _

Rules.

%% Atoms.

{LowerCase}({UpperCase}|{LowerCase}|{Digit}|{Underscore}|)* : {token, {atom, TokenLine, list_to_atom(TokenChars)}}.



Erlang code.
