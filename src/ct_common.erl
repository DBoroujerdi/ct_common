-module(ct_common).

-export([all/1,
         doc/1]).

%%------------------------------------------------------------------------------
%% public
%%------------------------------------------------------------------------------

all(Mod) ->
    lists:map(fun take_left/1, lists:filter(fun is_test/1, Mod:module_info(exports))).

doc(String) ->
    ct:comment(String),
    ct:log(String).

%%------------------------------------------------------------------------------
%% private
%%------------------------------------------------------------------------------

take_left({Fun, _}) -> Fun.

is_test({Fun, 1}) ->
    lists:suffix("_test", atom_to_list(Fun));
is_test(_) ->
    false.
