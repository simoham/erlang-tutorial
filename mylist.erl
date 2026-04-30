-module(mylist).
-export([last_acc/3, last/1, member/2]).

last(L) when is_list(L) ->
	last_acc(L, [], 0).

last_acc([], Last, Counter) -> {Last, Counter};
last_acc([H|L], _Last, Counter) ->
	last_acc(L, H, Counter+1).

member(L, Member) ->
	member(L, Member, 0).

member([Member|_], Member, Index) -> {true, Member, Index+1};
member([_H|L], Member, Index) ->
	member(L, Member, Index+1);
member([], Member, _) -> {false, Member}.

