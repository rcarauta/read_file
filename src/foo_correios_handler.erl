-module(foo_correios_handler).

-include("correios.hrl").

-export([init/2,terminate/3]).

init(Req0, State) ->

	CorreiosResponse = correios_client:'consultaCEP'(#'P0:consultaCEP'{'cep'="70385060"},[],[]),
	io:format("CorreiosResponse    ~p~n~n",[CorreiosResponse]),
	case CorreiosResponse of
		{ok,200,_,_,Response,_,_} ->
			    io:format("Response  ~p ~n~n",[Response]),
					Json = getResult(Response),
					CryptText = foo_start_handler:crypt_content(Json),
					io:format("CryptText ~p~n~n",[CryptText]),
					Req = cowboy_req:reply(200, #{
						<<"content-type">> => <<"application/json">>
					}, CryptText, Req0),
					PlainText  = foo_start_handler:decripty_content(CryptText),
					io:format("PlaintText  ~p~n~n",[PlainText]),
					{ok, Req, State};
		_ ->
			io:format("Error ")
	end.


	
terminate(_Reason, _Req, _State) ->
	ok.


getResult(Response) ->
	ListOfCep = element(2,Response),
	io:format("ListOfCep  ~p~n~n",[ListOfCep]),
	Bairro = element(2,ListOfCep),
	Cep = element(3,ListOfCep),
	Cidade = element(4,ListOfCep),
	Endereco = element(7,ListOfCep),
	Estado = element(9,ListOfCep),
	"{\"bairro\":\""++Bairro++"\", \"cep\":\""++Cep++"\", \"cidade\":\""++Cidade++"\", \"endereco\":\""++Endereco++"\", \"estado\":\""++Estado++"\"}".