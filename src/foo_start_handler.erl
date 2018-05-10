-module(foo_start_handler).

-export([init/2,terminate/3]).

init(Req0, State) ->
	Req = cowboy_req:reply(200, #{
		<<"content-type">> => <<"application/json">>
	}, <<"{\"other\": \"Web Service Home!\"}">>, Req0),
	{ok, Req, State}.
	
terminate(_Reason, _Req, _State) ->
	ok.
	
	
	
%% decripty_content() ->
%% 	CryptoText = ems_http_util:parse_barer_authorization_header(Authorization),
%% 	PrivateKey = ems_util:open_file("/home/rcarauta/desenvolvimento/erlang/read_file/priv/catalog" ++  "/" ++ binary_to_list(<<"private_key.pem">>)),
%% 	TextPlain = ems_util:decrypt_private_key(CryptoText,PrivateKey),
%% 	?DEBUG("TextPlain ~p", [TextPlain]).
	
	
%% crypt_content() ->
%% 	ResponseData2 = ems_schema:prop_list_to_json(ResponseData),
%% 	UserResponseData = lists:keyfind(<<"resource_owner">>, 1, ResponseData),
%% 	PublicKey = ems_util:open_file("/home/rcarauta/desenvolvimento/erlang/read_file/priv/catalog" ++  "/" ++ binary_to_list(<<"public_key.pem">>)),
%%  CryptoText = ems_util:encrypt_public_key(ResponseData2,PublicKey),
%% 	CryptoBase64 = base64:encode(CryptoText).
	
	
%% encrypt_public_key(PlainText, PublicKey) ->
%% 	[ RSAEntry2 ] = public_key:pem_decode(PublicKey),
%% 	PubKey = public_key:pem_entry_decode( RSAEntry2 ),
%% 	public_key:encrypt_public(PlainText, PubKey).
	
%% decrypt_private_key(CryptText,PrivateKey) ->
%%     [ RSAEntry2 ] = public_key:pem_decode(PrivateKey),
%% 	PrivKey = public_key:pem_entry_decode( RSAEntry2 ),
%% 	Result =  public_key:decrypt_private(CryptText, PrivKey ),
%% 	Result.
