-module(logger).

-export([logger_format/1]).

logger_format(Content) ->
    io:format("~p  ~n",[Content]).