-module(oauth2_barramento_resource).

-export([
         init/2
         ,rest_init/2
         ,allowed_methods/2
         ,is_authorized/2
        ]).

-export([
         content_types_provided/2
         ,content_types_accepted/2
        ]).

-export([
         process_get/2
         ,process_put/2
        ]).

%%%===================================================================
%%% Cowboy callbacks
%%%===================================================================

init(_Transport, _Req) ->
    {upgrade, protocol, cowboy_rest}.

rest_init(Req, _Opts) ->
    {ok, Req, undefined_state}.

allowed_methods(Req, State) ->
    {[<<"GET">>, <<"PUT">>], Req, State}.

is_authorized(Req, State) ->
    case get_access_token(Req) of
        {ok, Token} ->
            case oauth2:verify_access_token(Token, []) of
                {ok, _Identity} ->
                    {true, Req, State};
                {error, access_denied} ->
                    {{false, <<"Bearer">>}, Req, State}
            end;
        {error, _} ->
            {{false, <<"Bearer">>}, Req, State}
    end.

content_types_provided(Req, State) ->
    {[{{<<"application">>, <<"json">>, []}, process_get}], Req, State}.

content_types_accepted(Req, State) ->
    {[{{<<"application">>, <<"json">>, []}, process_put}], Req, State}.

process_put(Req, State) ->
    {true, Req, State}.

process_get(Req, State) ->
    {<<>>, Req, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

get_access_token(Req) ->
    case cowboy_req:header(<<"authorization">>, Req) of
        {<<"Bearer ", Token/binary>>, _Req} ->
            {ok, Token};
        _ ->
            case cowboy_req:qs_val(<<"access_token">>, Req) of
                {Token, _Req} ->
                    {ok, Token};
                _ ->
                    {error, missing}
            end
    end.