-module(pure_function).
-export([arith/1, add/2, fun_add/2, list_loop/3, double_list/1]).

%% G=10.

%% add({add, 2, 4}) -> 6.
%% add({sub, 5, 3}) -> 2.
%% add({mul, 10, 10} -> 100.
%%

%% {{add, 2, 3}, {sub, 3, 4}}
%% {"name":"simo"} --> {name, <<"simo">>}}
%% {"name":"simo", "programming" :["javascript", "erlang", "go"]} -> {{name, "simo"}, {programming, []}}
%%
%%
%%

%% arith({add, "hello", 2}) -> no clause matching
%%
%%
%% arith({add, 2, "3"})

arith({add, X, Y}) when is_integer(X), is_integer(Y) -> {ok, X+Y};
arith({mul, X, Y}) -> {ok, X*Y};
arith({sub, X, Y}) -> {ok, X-Y};
arith(_) -> error.

add(X, Y) -> X + Y.
fun_add(X, Y) -> fun() -> X+Y end.

%% fun(X) -> case erlang:is_integer(X) of
%% 		true -> 2*X;
%% 		false -> error
%% 		end
%% end

list_loop([], _, Acc) -> Acc;
list_loop([H|L], F, []) ->
	list_loop(L, F, F(H));
list_loop([H|L], F, A) ->
	list_loop(L, F, [F(H)|A]).

double_list(L) ->
	list_loop(L, fun(X) -> 2*X end, []).
