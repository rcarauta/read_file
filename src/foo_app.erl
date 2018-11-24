-module(foo_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, path_router/1, create_path/3]).

-define(C_ACCEPTORS,  100).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	logger:logger_format("Initiate project read_file ..."),
	database_connection:start(),
	logger:logger_format("Connection can be started ..."),
	database_connection:start_mnesia(),
	start_mnesia_tables(),
	logger:logger_format("Started mnesia ...."),
	oauth2_barramento_backend:start(),
	io:format("Authneticated ~n"),
    foo_sup:start_link().
    

stop(_State) ->
	logger:logger_format("Stoping services ..."),
    ok.


start_mnesia_tables() -> 
	database_connection:create_all_tables().    
 
create_path(Path, Service, RequestMethod) ->
	  io:format("RequestMethod ~p ~n",[RequestMethod]),
      [{Path,Service,[]}].
		


path_router(Route) -> 
	Dispatch = cowboy_router:compile([{'_', Route}]),
	{ok, _} = cowboy:start_clear(http, [{port, 8081}], #{
		env => #{dispatch => Dispatch}
	}).
    

    
    
   
