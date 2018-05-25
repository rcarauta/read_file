-module(foo_sample_handler).

-export([init/2,terminate/3]).

init(Req0, State) ->
	CryptText = foo_start_handler:crypt_content("{\"other\": \"Web Service Sample!\"}"),

	Req = cowboy_req:reply(200, #{
		<<"content-type">> => <<"application/json">>
	}, CryptText, Req0),
	PlainText  = foo_start_handler:decripty_content(CryptText),
	io:format("PlaintText  ~p~n~n",[PlainText]),
	{ok, Req, State}.
	
terminate(_Reason, _Req, _State) ->
	ok.
