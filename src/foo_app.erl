-module(foo_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, path_router/1]).

-define(C_ACCEPTORS,  100).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	path_router("/"),
    foo_sup:start_link().
    

stop(_State) ->
    ok.
    
    


path_router(Route) -> 
	Dispatch = cowboy_router:compile([
		{'_', [
			{Route, foo_handler, []}
		]}
	]),
	io:format("Route  ~p  ~n~n",[Route]),
	{ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}).
    

    
    
   
