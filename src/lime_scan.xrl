Definitions.

D          = [0-9]
Space      = [\s\n\r\t]

Rules.

%% Spaces.
{Space} : skip_token.

%% Numbers.

{D}+ : {token, {number, TokenLine, list_to_integer(TokenChars)}}.
{D}+\.{D}+((E|e)(\+|\-)?{D}+)? : {token, {number, TokenLine, list_to_float(TokenChars)}}.

%% Quotations.
\[ : {token, {quotation_open, TokenLine}}.
\] : {token, {quotation_close, TokenLine}}.

%% Atoms.

`[^\s\n\r\t]+ : {token, {atom, TokenLine, list_to_atom(TokenChars)}}.

%% Words.

[^\s\n\r\t]+ : {token, {word, TokenLine, list_to_atom(TokenChars)}}.

Erlang code.
