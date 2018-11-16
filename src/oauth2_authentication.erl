-module(oauth2_authentication).

-export([client_credentials_grant/2]).


client_credentials_grant(Request, Client) ->
    io:format("Enter in client_credential  ~n"),
    try
        Authz = oauth2:authorize_client_credentials(Client, []),
        io:format("Authz >>>>>>>>>>>>>>> ~p ~n ~n",[Authz])
    catch
        _:_ -> {error, access_denied, eparse_client_credentials_grant_exception}
    end.