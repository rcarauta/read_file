-module(foo_start_server).

-export([execute/1]).

execute(FileName) ->
	ContentFile = foo_json_compile:readlines(FileName),
	Service = read_catalog:get_propertires_json(ContentFile,"url"),
	foo_app:path_router(binary_to_list(Service)).
