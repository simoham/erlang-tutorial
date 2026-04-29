-module(map).
-export([map_it/2]).

map_it(Fun, List1) ->
	map_it_acc(Fun, List1, []).

map_it_acc(_Fun, [], Acc) -> Acc;
map_it_acc(Fun, [H|L], Acc) ->
	map_it_acc(Fun, L, [Fun(H)]++Acc).

even(X) ->
	case X div 2 of
		true -> true;
		false -> false
	end
