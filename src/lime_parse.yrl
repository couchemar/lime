Nonterminals
    program exprs fun_expr fun_args fun_arg fun_body add_expr
    module_def.

Terminals
    module fun '=' end lower_atom upper_atom
    '+'.

Rootsymbol program.

%%Expect 3.


program -> module_def : '$1'.
module_def -> module upper_atom '=' exprs end : {module, line('$1'), '$2', '$4'}.

exprs -> fun_expr : '$1'.

fun_expr -> fun fun_args '=' fun_body : {fn, line('$1'), '$2', '$4'}.

fun_args -> fun_arg : ['$1'].
fun_args -> fun_arg fun_args : ['$1'|'$2'].

fun_arg -> lower_atom : '$1'.

fun_body -> add_expr : '$1'.

add_expr -> lower_atom '+' lower_atom : {op, '$2', '$1', '$3'}.


Erlang code.

line({_, L}) ->
    L;
line({_, L, _}) ->
    L.