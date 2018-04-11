-module(foo).

-export([start/0]).


start() -> 
	application:start(crypto),
	ssl:start(),
	application:start(ibrowse),
	application:start(jiffy),
	application:start(ranch),
    application:start(cowlib),
	application:start(cowboy),
	application:start(foo).
