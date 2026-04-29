-module(proc).
-export([start/0, get_counter/1, loop/1, reset_counter/2]).

start() ->
	Pid=spawn(fun() -> loop(0) end),
	Pid.

get_counter(Pid) ->
	Pid ! {self(), get_counter},
	receive
		{From, {counter, Counter}} -> io:format("From: ~p Counter ~p ~n", [From, Counter]);
		_ -> error	
	end.

reset_counter(Pid, Value) when is_integer(Value) ->
        Pid ! {self(), {reset_counter, Value}},
        receive
                {From, {ok, Counter}} -> io:format("Reset  ToFrom: ~p Counter ~p ~n", [From, Counter]);
                _ -> error
        end.


%% #{counter=>Counter, update=>timestamp}

loop(Counter) ->
	receive
		{From, get_counter} -> From ! {self(), {counter, Counter}}, loop(Counter+1);
		{From, {reset_counter, Value}} -> From ! {self(), {ok, Value}}, loop(Value);
		_ -> error
	end,
	loop(Counter).
