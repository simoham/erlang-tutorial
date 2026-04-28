-module(erllist).
-export([double_list/1, triple_list/1, fun_list_acc/3, for/3]).

double_list(L) when is_list(L) -> 
	fun_list_acc(L, [], fun(X) -> 2*X end).

triple_list(L) when is_list(L) ->
	fun_list_acc(L, [], fun(X) -> 3*X end).

fun_list_acc([], Acc, _F) -> Acc;
fun_list_acc([H|L], Acc, F) ->
	fun_list_acc(L, Acc++[F(H)], F).

for(I, Max, Fun) ->
	for_acc(I, Max, Fun, []).

%% for_acc(0, 100, fun(X) -> rand:uniform(100)+X end, [])

for_acc(Max, Max, _, Acc) -> Acc;
for_acc(I, Max, Fun, Acc) ->
	for_acc(I+1, Max, Fun, [Fun(I)]++Acc).
