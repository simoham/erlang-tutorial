-module(gold_server).
-behaviour(gen_server).

%% API (Client-side functions)
-export([start_link/0, fibonacci/1, factorial/1, stop/0]).

%% gen_server callbacks (Server-side functions)
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% --- API Section ---

%% Starts the server and registers it under the name 'gold_server'
start_link() ->
    gen_server:start_link({local, gold_server}, ?MODULE, [], []).

%% Synchronous: Waits for the server to store the value and return 'ok'
fibonacci(Value) ->
    gen_server:call(gold_server, {fibonacci, Value}).

%% Synchronous: Requests a value and waits for the response
factorial(Value) ->
    gen_server:call(gold_server, {factorial, Value}).

%% Asynchronous: Sends a stop message and returns immediately
stop() ->
    gen_server:cast(gold_server, stop).

%% --- gen_server Callbacks Section ---

%% Initializes the server state as an empty map
init([]) ->
    {ok, #{counter=>0, factorial=>0, fibonacci=>0}}.

%% Handles synchronous 'call' requests
%%  gold_server:handle_call({fibonacci, Value}, From, State)

handle_call({fibonacci, Value}, _From, State) ->
    Fib = gold_api:fibonacci(Value),
    NewCounter=maps:get(counter, State)+1,
    NewState = #{counter=>NewCounter, fibonacci=>Fib, factorial=>maps:get(factorial, State)},
    {reply, {ok, Fib}, NewState};

handle_call({factorial, Value}, _From, State) ->
    Factorial = gold_api:factorial(Value),
    NewCounter=maps:get(counter, State)+1,
    NewState = #{counter=>NewCounter, fibonacci=>maps:get(fibonacci, State), factorial=>Factorial},
    {reply, {ok, Factorial}, NewState}.

%% Handles asynchronous 'cast' requests
handle_cast(stop, State) ->
    {stop, normal, State}.

%% Handles standard Erlang messages (e.g., from ! operator)
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

