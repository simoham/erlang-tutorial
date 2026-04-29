-module(triplet).
-export([run/1]).

run(N) when is_integer(N) ->

	[{A, B, C} || A <- lists:seq(1, N), 
		      B <- lists:seq(1, N),
		      C <- lists:seq(1, N),
		      A+B+C < N,
		      C*C =:= A*A+B*B
	].
