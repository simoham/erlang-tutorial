%%%-------------------------------------------------------------------
%% @doc hello top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(hello_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    SupFlags = #{
        strategy => one_for_one,
        intensity => 0,
        period => 1
    },
    ChildSpecs = [
	#{
	id => hello_counter,
  	start => {hello_counter, start_link, [ok]},
  	restart => permanent,  % permanent | transient | temporary
  	shutdown => 5000,      % timeout() | brutal_kill
  	type => worker,        % worker | supervisor
  	modules => [hello_counter] % [module()] | dynamic
	}
    ],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
