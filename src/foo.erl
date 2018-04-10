-module(foo).

-export([start/0]).


start() ->
	application:start(ibrowse),
	application:start(jiffy),
	application:start(foo).
