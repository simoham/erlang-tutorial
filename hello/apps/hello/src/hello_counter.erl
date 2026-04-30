-module(hello_counter).
-export([start_link/1, init/1, loop/1]).

start_link(_Args) ->
    % Use spawn_link to ensure the supervisor monitors this process
    Pid=proc_lib:spawn_link(?MODULE, init, [self()]),
    {ok, Pid}.

init(Parent) ->
    % Perform setup code here
    register(?MODULE, self()),
    proc_lib:init_ack(Parent, {ok, self()}),
    loop(0).

loop(Counter) ->
    receive
        % Handle messages or events
        stop -> ok;
	increment -> loop(Counter+1);
	{From, get} -> From ! {ok, Counter}
    end, loop(Counter).
