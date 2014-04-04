Definitions.

D          = [0-9]
UC  = [A-Z]
LC  = [a-z]
Underscore = _
Space      = [\s\n\r\t]
Symbols    = [-+*/]

Rules.

%% Atoms.

{LC}({UC}|{LC}|{D}|{Underscore})* : {token, lower_atom_or_keyword(TokenLine, TokenChars)}.
{UC}({UC}|{LC}|{D}|{Underscore})* : {token, {upper_atom, TokenLine, list_to_atom(TokenChars)}}.


%% Symbols.
{Symbols}+ : {token, {symbol, TokenLine, list_to_atom(TokenChars)}}.


%% Spaces.
{Space} : skip_token.

%% Numbers.

{D}+ : {token, {number, TokenLine, list_to_integer(TokenChars)}}.
{D}+\.{D}+((E|e)(\+|\-)?{D}+)? : {token, {number, TokenLine, list_to_float(TokenChars)}}.


Erlang code.

lower_atom_or_keyword(TokenLine, TokenChars) ->
    case is_reserved(TokenChars) of
        true ->
            {list_to_atom(TokenChars), TokenLine};
        false ->
            {lower_atom, TokenLine, list_to_atom(TokenChars)}
    end.

is_reserved(_) -> false.
