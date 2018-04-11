-module(read_catalog).

-export([read_json/1,get_propertires_json/2]).


read_json(PathFile) ->
	ContentFile = foo_json_compile:readlines(PathFile),
	{DecodeContent} = foo_json_compile:decode(ContentFile),
	proplists:get_value(<<"name">>, DecodeContent).
	
	
get_propertires_json(ContentFile,Prop) ->
	io:format("Prop ~p ~n~n",[Prop]),
	{DecodeContent} = foo_json_compile:decode(ContentFile),
	io:format("DecodeContent ~p ~n~n",[DecodeContent]),
	proplists:get_value(list_to_binary(Prop), DecodeContent).
