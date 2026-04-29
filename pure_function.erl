-module(pure_function).
-export([arith/1, arith1/1, arith2/1, add/2, fun_add/2, list_loop/3, double_list/1]).
-export([filter/2, filter_joe/2, filter_acc/3, filter_comprehension/2]).
-export([if_max/2]).

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

arith1(Term) ->
	Res = case Term of
		{add, X, Y} when is_integer(X), is_integer(Y) -> X+Y;
		{sub, X, Y} -> X-Y;
		{mul, X, Y} -> X*Y;
		_ -> {error, does_not_match}
	end,
	{ok, Res}.

arith2(Term) ->
	Res = case Term of
		{_, X, Y} when is_integer(X), is_integer(Y) ->
			case Term of
				{add, _, _} -> X+Y;
				{sub, _, _} -> X-Y;
				{mul, _, _} -> X*Y
			end;
		_ -> {error, does_not_match}
	end,
	{ok, Res}.

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


%% f(x) -> true, put to list

filter(_Fun, []) -> [];
filter(Fun, [Head | Tail]) ->
	case Fun(Head) of
		true ->  [filter(Fun, Tail) ]++[Head];
		false -> [ filter(Fun, Tail)]
	end.


filter_joe(P, [H|T]) ->
	case P(H) of
		true -> [H|filter(P, T)];
		false -> filter(P, T)
	end;
filter_joe(_P, []) ->
	[].

filter_acc(_Fun, [], Acc) -> Acc;
filter_acc(Fun, [Head |Tail], Acc ) ->
	case Fun(Head) of
		true -> filter_acc(Fun, Tail, [Head]++Acc);
		false -> filter_acc(Fun, Tail, Acc)
	end.

filter_comprehension(Fun, L) ->
	[ X || X <- L, Fun(X) ].

if_max(A, B) when is_integer(A), is_integer(B) ->
	Res = if 
		A > B -> {ok, a_bigger_then_b, {A, B}};
		A < B -> {ok, a_small_then_b, {A, B}}
	end,
	{ok, {result, Res}}.
