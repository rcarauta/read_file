-module(oauth2_barramento_auth).

-export([init/3, rest_init/2, allowed_methods/2, content_types_provided/2,
        content_types_accepted/2, process_post/2, process_get/2]).

init(_Transport, _Req, _Opts) ->
    {ok, auth_form} = erlydtl:compile(filename:join(["priv", "static", "auth_from.dtl"]),
                                auth_form),
    {upgrade, protocol, cowboy_rest}.


rest_init(Req, _Opts) ->
    {ok, Req, undefined_state}.


allowed_methods(Req, State) ->
    {[<<"POST">>, <<"GET">>], Req, State}.


content_types_provided(Req, State) ->
    {[{{<<"text">>, <<"html">>, []}, process_get}], Req, State}.


content_types_accepted(Req, State) ->
    {[{{<<"application">>, <<"json">>, []}, process_post},
    {{<<"application">>, <<"x-www-form-urlencoded">>, []}, process_post}],
    Req, State}.


process_post(Req, State) ->
    {ok, Body, Req2} = cowboy_req:body(Req),
    Params = decode_form(Body),
    {ok, Reply} =
            case lists:max([proplists:get_value(K, Params)
                            || K <- [<<"grant_type">>, <<"response_type">>]]) of
                <<"password">> ->
                    process_password_grant(Req2, Params);
                <<"client_credentials">> ->
                    process_client_credentials_grant(Req2, Params);
                <<"token">> ->
                    process_implicit_grant_stage2(Req2, Params);
                _ ->
                    cowboy_req:reply(400, [], <<"Bad Request">>, Req2)
            end,
        {halt, Reply, State}.


process_get(Req, State) ->
    {ResponseType, Req2} = cowboy_req:qs_val(<<"response_type">>, Req),
    {ok, Reply} =
        case ResponseType of 
            <<"token">> ->
                {Req3, Params} =
                    lists:foldl(fun(Name, {R, Acc}) ->
                                    {Val, R2} = 
                                        cowboy_req:qs_val(Name, R),
                                    {R2, [{Name, Val} | Acc]}
                                end,
                                {Req2, []},
                                [<<"client_id">>,
                                <<"redirect_uri">>,
                                <<"scope">>,
                                <<"state">>]),
                    process_implicit_grant(Req3, Params);
            _ ->
                JSON = jsx:encode([{error, <<"unsuported_response_type">>}]),
                cowboy_req:reply(400, [], JSON, Req2)
        end,
    {halt, Reply, State}.


%% Internal functions

process_password_grant(Req, Params) ->
    Username = proplists:get_value(<<"username">>, Params),
    Password = proplists:get_value(<<"password">>, Params),
    Scope = proplists:get_value(<<"scope">>, Params, <<"">>),
    Auth = auth2:authorize_password(Username, Password, Scope, []),
    issue_token(Auth, Req).


process_client_credentials_grant(Req, Params) ->
    {<<"Basic", Credentials/binary>>, Req2} =
        cowboy_req:header(<<"authorization">>, Req),
        [Id, Secret] = binary:split(base64:decode(Credentials), <<":">>),
        Scope = proplists:get_value(<<"scope">>, Params),
        Auth = oauth2:authorize_client_credentials(Id, Secret, Scope, []),
        issue_token(Auth, Req2).


process_implicit_grant(Req, Params) ->
    State       = proplists:get_value(<<"state">>, Params),
    Scope       = proplists:get_value(<<"scope">>, Params, <<>>),
    ClientId    = proplists:get_value(<<"client_id">>, Params),
    RedirectUri = proplists:get_value(<<"redirect_uri">>, Params),
        case oauth2:verify_redirection_uri(ClientId, RedirectUri) of
        ok ->
            {ok, Html} = auth_form:render([{redirect_uri, RedirectUri},
                                           {client_id, ClientId},
                                           {state, State},
                                           {scope, Scope}]),
            cowboy_req:reply(200, [], Html, Req);
        {error, Reason} ->
            redirect_resp(RedirectUri,
                           [{<<"error">>, to_binary(Reason)},
                            {<<"state">>, State}],
                           Req)
    end.

decode_form(Form) ->
    RawForm = cow_http:urlencoded(Form),
    Pairs = binary:split(RawForm, <<"&">>, [global]),
    lists:map(fun(Pair) ->
                    [K, V] = binary:split(Pair, <<"=">>),
                    {K, V}
              end, Pairs).


process_implicit_grant_stage2(Req, Params) ->
    ClientId = proplists:get_value(<<"client_id">>, Params),
    RedirectUri = proplists:get_value(<<"redirect_uri">>, Params),
    Username = proplists:get_value(<<"username">>, Params),
    Password = proplists:get_value(<<"password">>, Params),
    State = proplists:get_value(<<"state">>, Params),
    Scope = proplists:get_value(<<"scope">>, Params, <<"">>),
    case oauth2:verify_redirection_url(ClientId, RedirectUri) of 
        ok ->
            case oauth2:authorize_password(Username, Password, Scope) of 
                {ok, Response} ->
                    Props = [{<<"state">>, State} 
                            | oauth2_response:to_proplist(Response)],
                        redirect_resp(RedirectUri, Props, Req);
                {error, Reason} ->
                    redirect_resp(RedirectUri,
                                [{<<"error">>, to_binary(Reason)},
                                  {<<"state">>, State}], Req)
            end;
        {error, _} ->
            cowboy_req:reply(400, Req)
    end.


issue_token({ok, Auth}, Req) ->
    emit_response(oauth2:issue_token(Auth,[]), Req);
issue_token(Error, Req) ->
    emit_response(Error, Req).


emit_response(AuthResult, Req) ->
    {Code, JSON} =
        case AuthResult of 
            {error, Reason} ->
                {400, jsx:encode([{error, to_binary(Reason)}])};
            Response ->
                {200, jsx:encode(to_json_term(oauth2_response:to_proplist(Response), []))}
        end,
        cowboy_req:reply(Code, [], JSON, Req).


redirect_resp(RedirectUri, FragParams, Req) ->
    Frag = binary_join([<<(cowboy_http:urlencoded(K)/binary), "=",
                          (cowboy_http:urlencoded(V)/binary)>>
                           ||  {K, V} <- FragParams], <<"&">>),
    Header = [{<<"location">>, <<RedirectUri/binary, "#", Frag/binary>>}],
    cowboy_req:reply(302, Header, <<>>, Req).


binary_join([H], _Sep) ->
    <<H/binary>>;
binary_join([H|T], Sep) ->
    <<H/binary, Sep/binary, (binary_join(T, Sep))/binary>>;
binary_join([], _Sep) ->
    <<>>.


to_json_term([], Acc) ->
    Acc;
to_json_term([{H,{HK, HV}} | T], Acc) ->
    to_json_term(T, [{H, <<"{", HK/binary, ",", HV/binary, "}">>} | Acc]);
to_json_term([H | T], Acc) ->
    to_json_term(T, [H | Acc]).


to_binary(Atom) when is_atom(Atom) ->
    list_to_binary(atom_to_list(Atom)).



