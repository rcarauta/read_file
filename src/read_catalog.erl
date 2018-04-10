-module(read_catalog).

-export([read_json/1]).


read_json(PathFile) ->
	ContentFile = foo_json_compile:readlines(PathFile),
	{DecodeContent} = foo_json_compile:decode(ContentFile),
	proplists:get_value(<<"name">>, DecodeContent).
