-module(dispatcher_types).

-define(CONTENT_TYPE_JSON, <<"application/json; charset=utf-8"/utf8>>).

-export([dispatcher/1]).


dispatcher(Type) ->
    case Type of 
        <<"OPTIONS">> -> 
                    {ok, request, {code = 200, 
                                            content_type_out = ?CONTENT_TYPE_JSON,
                                            response_data = "{\"response\":\"resposta_options\"}"}
                    };
         <<"GET">> -> 
                    {ok, request, {code = 200, 
                                            content_type_out = ?CONTENT_TYPE_JSON,
                                            response_data = "{\"response\":\"resposta_get\"}"}
                     };
         <<"POST">> -> 
                    {ok, request, {code = 200, 
                                            content_type_out = ?CONTENT_TYPE_JSON,
                                            response_data = "{\"response\":\"resposta_post\"}"}
                    };
        <<"PUT">> -> 
                    {ok, request, {code = 200, 
                                            content_type_out = ?CONTENT_TYPE_JSON,
                                            response_data = "{\"response\":\"resposta_put\"}"}
                    };
        <<"DELETE">> -> 
                    {ok, request, {code = 200, 
                                            content_type_out = ?CONTENT_TYPE_JSON,
                                            response_data = "{\"response\":\"resposta_delete\"}"}
                    };
        _ ->
			erlang:error(ehttp_verb_not_supported)
        end.