Definitions.

D          = [0-9]
UpperCase  = [A-Z]
LowerCase  = [a-z]
Underscore = _
Space      = [\s\n\r\t]
Symbols    = [+-=/*]

Rules.

%% Atoms.

{LowerCase}({UpperCase}|{LowerCase}|{D}|{Underscore}|)* : {token, {atom, list_to_atom(TokenChars), TokenLine}}.
{Symbols}+ : {token, {atom, list_to_atom(TokenChars), TokenLine}}.


%% Spaces.
{Space} : skip_token.

%% Numbers.

{D}+ : {token, {number, list_to_integer(TokenChars), TokenLine}}.
{D}+\.{D}+((E|e)(\+|\-)?{D}+)? : {token, {number, list_to_float(TokenChars), TokenLine}}.


Erlang code.
