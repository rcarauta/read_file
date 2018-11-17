-module(oauth2_barramento_backend).

-export([start/0, stop/0, add_user/2, delete_user/1, add_client/2, add_client/3,
        delete_client/1, authenticate_username_password/3,  authenticate_client/3,
        get_client_identity/2]).

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


