-module(foo_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, path_router/1, create_path/2]).

-define(C_ACCEPTORS,  100).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    foo_sup:start_link().
    

stop(_State) ->
    ok.
    
 
create_path(Path, Service) ->
      [{Path,Service,[]}].
		


path_router(Route) -> 
	Dispatch = cowboy_router:compile([{'_', Route}]),	
	{ok, _} = cowboy:start_clear(http, [{port, 8081}], #{
		env => #{dispatch => Dispatch}
	}).
    

    
    
   
