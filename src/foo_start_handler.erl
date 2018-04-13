-module(foo_start_handler).

-export([init/2,terminate/3]).

init(Req0, State) ->
	Req = cowboy_req:reply(200, #{
		<<"content-type">> => <<"application/json">>
	}, <<"{\"other\": \"Another webservice!\"}">>, Req0),
	{ok, Req, State}.
	
terminate(_Reason, _Req, _State) ->
	ok.
