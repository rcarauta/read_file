-module(barramento_service).

-include("barramento_constaints.hrl").

-export([start/1, stop/1, handle_function/2]).

start(Port) ->
    thrift_socket_server:start([{handle, ?MODULE},
                                {port, Port},
                                {service, barramentoService_thrift},
                                {name, barramentoService_thrift}]).

stop(Server) ->
    thrift_socket_server:stop(Server).

handle_function(hello, {TheMessageRecord}) ->
    _Id = TheMessageRecord#message.id,
    _Msg = TheMessageRecord#message.text,
    {reply, #message{id =1, text = <<"Thanks!">>}}.