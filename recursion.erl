-module(recursion).
-export([factorial/1, ackermann/2, fibonacci/1, golden/2]).

factorial(0) -> 1;
factorial(N) when is_integer(N), N >= 0 ->
	N*factorial(N-1).

ackermann(0, N) -> N+1;
ackermann(M, 0) -> ackermann(M-1, 1);
ackermann(M, N) -> ackermann(M-1, ackermann(M, N-1)).

%%

fibonacci(1) -> 1;
fibonacci(0) -> 0;
fibonacci(N) when is_integer(N), N > 1 ->
	fibonacci(N-1)+fibonacci(N-2).

%% Phi = F(N+1)/F(N)

golden([_H], Acc) -> Acc;
golden([], Acc) -> Acc;
golden([H, H1 |L], Acc) ->
	golden(L, Acc++[H1/H]).
