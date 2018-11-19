-module(oauth2_barramento_backend).

-export([start/0, stop/0, add_user/2, delete_user/1, add_client/2, add_client/3,
        delete_client/1, authenticate_username_password/3,  authenticate_client/3,
        get_client_identity/2, associate_access_code/3, associate_refresh_token/3, associate_access_token/3,
        resolve_access_code/2, resolve_refresh_token/2, resolve_access_token/2, revoke_access_code/2,
        revoke_access_token/2, revoke_refresh_token/2, get_redirection_uri/2, verify_redirection_uri/3,
        verify_client_scope/3, verify_resowner_scope/3, verify_scope/3]).


-record(client,{
    client_id :: binary(),
    client_secret :: binary(),
    client_url :: binary()
}).

-record(user, {
    username :: binary(),
    password :: binary()
}).

-define(ACCESS_TOKEN_TABLE, access_tokens).
-define(REFRESH_TOKEN_TABLE, refresh_tokens).
-define(USER_TABLE, users).
-define(CLIENT_TABLE, clients).

-define(TABLES, [?ACCESS_TOKEN_TABLE,
                 ?REFRESH_TOKEN_TABLE,
                 ?USER_TABLE,
                 ?CLIENT_TABLE]).

start() ->
    lists:foreach(fun(Table) ->
                    ets:new(Table,[named_title, public])
                  end, ?TABLES),
        oauth2_barramento_backend:add_client(<<"my_client">>,<<"ohai">>, 
                                    <<"https://kirva.com">>),
        oauth2_barramento_backend:add_user(<<"martin">>, <<"ohai">>).


stop() ->
    lists:foreach(fun ets:delete/1, ?TABLES).


add_user(Username, Password) ->
    put(?USER_TABLE, Username, #user{username = Username, password = Password}).


delete_user(Username) ->
    delete(?USER_TABLE, Username).


add_client(Id, Sercret, RedirectUri) ->
    put(?CLIENT_TABLE, Id, #client{client_id = Id,
                                   client_secret = Secret,
                                   redirect_uri = RedirectUri}).



add_client(Id, Secret) ->
    add_client(Id, Secret, undefined).


delete_client(Id) ->
    delete(?CLIENT_TABLE, Id).


%% Oauth2 Functions

authenticate_username_password(Username, Password, _) ->
    case get(?USER_TABLE, Username) of 
        {ok, #user{password = UserPw}} ->
            case Password of 
                UserPw ->
                    {ok, {<<"user">>, Username}};
                _ ->
                    {error, badpass}
            end;
        Error = {error, notfound} ->
            Error
    end.


authenticate_client(ClientId, ClientSecret, _) ->
    case get(?CLIENT_TABLE, ClientId) of 
        {ok, #client{client_secret = ClientSecret}} ->
            {ok, {<<"cleint">>, ClientId}};
        {ok , #client{client_secret = _Wrongsecret}} ->
            {error, badsecret};
        _ ->
            {error, notfound}
    end.


get_client_identity(ClientId, _) ->
    case get(?CLIENT_TABLE, ClientId) of 
        {ok, _} ->
            {ok, {<<"client">>, ClientId}};
        _ ->
            {error, notfound}
    end. 


associate_access_code(AccessCode, Context, _AppContext) ->
    associate_access_token(AccessCode, Context, _AppContext).


associate_refresh_token(RefreshToken, Context, _) ->
    put(?REFRESH_TOKEN_TABLE, RefreshToken, Context).

associate_access_token(AccessToken, Context, _) ->
    put(?ACCESS_TOKEN_TABLE, AccessToken, Context).


resolve_access_code(AccessCode, _AppContext) ->
    resolve_access_token(AccessCode, _AppContext).

resolve_refresh_token(RefreshToken, _AppContext) ->
    resolve_access_token(RefreshToken, _AppContext).

resolve_access_token(AccessToken, _) ->
    case get(?ACCESS_TOKEN_TABLE, AccessToken) of 
        Value = {ok, _} ->
            Value;
        Error = {error, notfound} ->
            Error
    end.


revoke_access_code(AccessCode, _AppContext) ->
    revoke_access_token(AccessCode, _AppContext).


revoke_access_token(AccessToken, _) ->
    delete(?ACCESS_TOKEN_TABLE, AccessToken),
    ok.


revoke_refresh_token(_RefreshToken, _) ->
    ok.


get_redirection_uri(ClientId, _) ->
    case get(?CLIENT_TABLE, ClientId) of 
        {ok, #client{redirect_uri = RedirectUri}} ->
            {ok, RedirectUri};
        Error = {error, notfound} ->
            Error
    end.


verify_client_scope(_ClientId, Scope, _) ->
    {ok, Scope}.


veriry_resowner_scope(_ResOwner, Scope, _) ->
    {ok, Scope}.


verify_scope(Scope, Scope, _) ->
    {ok, Scope};
verify_scope(_, _, _) ->
    {error, invalid_scope}.


%% Internal Functions

get(Table, Key) ->
    case ets:lookup(Table, Key) of 
        [] ->
            {error, notfound};
        [{_Key, Value}] ->
            {ok, Value}
    end.


put(Table, Key, Value) ->
    ets:insert(Table, {Key, Value}),
    ok.


delete(Table, Key) ->
    ets:delete(Table, Key).


