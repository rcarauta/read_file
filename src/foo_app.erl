-module(foo_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, path_router/1, create_path/2]).

-define(C_ACCEPTORS,  100).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	logger:logger_format("Initiate project read_file ..."),
	database_connection:start(),
	logger:logger_format("Connection can be started ..."),
	database_connection:start_mnesia(),
	logger:logger_format("Started mnesia ...."),
	start_mnesia_tables(),
    foo_sup:start_link().
    

stop(_State) ->
	logger:logger_format("Stoping services ..."),
    ok.

start_mnesia_tables() -> 
	database_connection:create_all_tables().    
 
create_path(Path, Service) ->
      [{Path,Service,[]}].
		


path_router(Route) -> 
	Dispatch = cowboy_router:compile([{'_', Route}]),	
	{ok, _} = cowboy:start_clear(http, [{port, 8081}], #{
		env => #{dispatch => Dispatch}
	}).
    

    
    
   
