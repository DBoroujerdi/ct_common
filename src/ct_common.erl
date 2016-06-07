-module(ct_common).

-export([all/1,
         doc/1]).

%%------------------------------------------------------------------------------
%% public
%%------------------------------------------------------------------------------

all(Mod) ->
    lists:map(fun fun_only/1, lists:filter(fun filter_test/1, Mod:module_info(exports))).

fun_only({Fun, _}) -> Fun.

filter_test({Fun, 1}) ->
    is_test_fun(rev(atom_to_binary(Fun, utf8)));
filter_test(_) ->
    false.

rev(Bin) ->
    rev(Bin, <<>>).

rev(<<>>, Acc) -> Acc;
rev(<<H:1/binary, Rest/binary>>, Acc) ->
    rev(Rest, <<H/binary, Acc/binary>>).

is_test_fun(<<"tset_", _/binary>>) ->
    true;
is_test_fun(_) ->
    false.


doc(String) ->
    ct:comment(String),
    ct:log(String).

%%------------------------------------------------------------------------------
%% private
%%------------------------------------------------------------------------------
