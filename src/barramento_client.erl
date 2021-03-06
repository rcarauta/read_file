-module(barramento_client).

-include("barramento_constants.hrl").

-export([request/4]).

request(Host, Port, Id, Msg) ->
    Req = #message{id = Id, text = Msg},
    {ok, Client} = thrift_client_util:new(Host, Port, barramentoService_thrift, []),
    {ClientAgain, {ok, Response}} = thrift_client:call(Client, hello, [Req]),
    thrift_client:close(ClientAgain),
    Response.