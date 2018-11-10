-module(read_catalog).

-export([read_all_files_Folder/0, get_propertires_json/2]).

	 
	
get_propertires_json(ContentFile,Prop) ->
	{DecodeContent} = foo_json_compile:decode(ContentFile),
	proplists:get_value(list_to_binary(Prop), DecodeContent).
	
	
read_all_files_Folder() ->
	{ok, FileNames} = file:list_dir("priv/catalog"),
	ListRouter = read_json(FileNames),
	foo_app:path_router(ListRouter).

read_json(FileNames) ->
	read_json(FileNames,[]).
	
read_json([PathFile | T], Acc) ->
	ContentFile = foo_json_compile:readlines(string:concat("priv/catalog/",PathFile)),
	{DecodeContent} = foo_json_compile:decode(ContentFile),
	 UrlPath = proplists:get_value(<<"url">>, DecodeContent),
	 Service = proplists:get_value(<<"service">>, DecodeContent),
	 RequestMethod = proplists:get_value(<<"type">>, DecodeContent),
	 Router = foo_app:create_path(binary_to_list(UrlPath),list_to_atom(binary_to_list(Service)), RequestMethod),
	 case Acc of
		[] -> Path = Router;
		_ -> Path =  Acc ++ Router
	 end, 
	 read_json(T,Path);
	  
read_json([],Acc) ->
	Acc.
