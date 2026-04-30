-module(generic).
-behaviour(gen_server).

%% API (Client Interface)
-export([start_link/0, increment/0, decrement/0, get_value/0, set_value/1, stop/0]).

%% gen_server callbacks
%%
%%
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% ====================================================================
%% API Functions
%% ====================================================================

%% Starts the server and registers it locally under the name 'counter'
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, 0, []).

%% Synchronous: Increments and returns the new value
increment() ->
    gen_server:call(?MODULE, inc).

%% Asynchronous: Decrements (returns 'ok' immediately without waiting)
decrement() ->
    gen_server:cast(?MODULE, dec).

%% Synchronous: Returns current state
get_value() ->
    gen_server:call(?MODULE, get).

set_value(Value) ->
    gen_server:call(?MODULE, {set, Value}).

stop() ->
    gen_server:stop(?MODULE).

%% ====================================================================
%% gen_server Callback Functions
%% ====================================================================

%% Sets the initial state (in this case, 0)
%% Module:init(Param)
%% generic:init(Param)

%% #{counter=>Counter, update=>Timestamp, function=>[]}

init(Count) ->
    {ok, Count}.

%% Handles synchronous calls (gen_server:call)
%% ?MODULE ! inc 

handle_call(inc, _From, Count) ->
    NewCount = Count + 1,
    {reply, NewCount, NewCount}; % {reply, Response, NewState}

handle_call(get, _From, Count) ->
    {reply, Count, Count};

handle_call({set, Value}, _From, _Count) ->
    %% Count need to get ignored
    {reply, Value, Value}.

%% Handles asynchronous casts (gen_server:cast)
handle_cast(dec, Count) ->
    {noreply, Count - 1}; % {noreply, NewState}

handle_cast(_Msg, State) ->
    {noreply, State}.

%% Handles standard messages (e.g., from '!' or timers)

handle_info({please_get, value}, State) ->
        {noreply, State+1};
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    %% ensure transition between oldversion and new version
    {ok, State}.

