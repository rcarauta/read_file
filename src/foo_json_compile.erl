-module(foo_json_compile).

-export([decode/1,encode/1,readlines/1]).


decode(Json) -> 
	Json2 = iolist_to_binary(Json),
	jiffy:decode(Json2).
	
	
encode(Doc) ->
	jiffy:encode(Doc).
	
	
readlines(FileName) ->
    {ok, Device} = file:open(FileName, [read]),
    try get_all_lines(Device)
      after file:close(Device)
    end.

get_all_lines(Device) ->
    case io:get_line(Device, "") of
        eof  -> [];
        Line -> Line ++ get_all_lines(Device)
    end.
