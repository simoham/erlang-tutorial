-module(leprocessus).
-export([start/0, sender/2, loop/1]).

%% leprocessus:start() <0.23.0>
%% Pid 
%% sender(Pid, Msg)
start() ->
	Pid=spawn(fun() -> loop(0) end),
	Pid.

sender(Pid, Msg) ->
	Pid ! {self(), Msg},
	receive
		{_From, {thanks, Msg, Counter}} -> io:format("Msg:~p Counter:~p~n", [Msg, Counter]);
		_ -> error
	end.

loop(Counter) ->
	receive
		{From, _Msg} -> From ! {thanks, "I got your message", Counter}, loop(Counter+1);
		_ -> error
	end,
	loop(Counter+1).
