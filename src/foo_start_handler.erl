-module(foo_start_handler).

-export([init/2,terminate/3, decripty_content/1, crypt_content/1 ]).

-define(JSON_LIB, jsx).

init(Req0, State) ->
	Req = cowboy_req:reply(200, #{
		<<"content-type">> => <<"application/json">>
	}, <<"{\"other\": \"Web Service Home!\"}">>, Req0),
	{ok, Req, State}.
	
terminate(_Reason, _Req, _State) ->
	ok.
	
	
	
decripty_content(CryptText) ->
 	CryptoText = parse_barer_authorization_header(CryptText),
 	PrivateKey = open_file("/home/rcarauta/desenvolvimento/erlang/read_file/priv/keys/private.pem"),
 	TextPlain = decrypt_private_key(CryptoText,PrivateKey),
 	TextPlain.
	
	
crypt_content(PlainText) ->
 	PublicKey = open_file("/home/rcarauta/desenvolvimento/erlang/read_file/priv/keys/public.pem"),
    CryptoText = encrypt_public_key(PlainText,PublicKey),
 	CryptoBase64 = base64:encode(CryptoText),
 	CryptoBase64.
	
	
	
encrypt_public_key(PlainText, PublicKey) ->
 	[ RSAEntry2 ] = public_key:pem_decode(PublicKey),
 	PubKey = public_key:pem_entry_decode( RSAEntry2 ),
 	public_key:encrypt_public(list_to_binary(PlainText), PubKey).
	
	
decrypt_private_key(CryptText,PrivateKey) ->
     [ RSAEntry2 ] = public_key:pem_decode(PrivateKey),
 	PrivKey = public_key:pem_entry_decode( RSAEntry2 ),
 	Result =  public_key:decrypt_private(CryptText, PrivKey, [{rsa_pad, rsa_pkcs1_padding}]),
 	Result.
 
parse_barer_authorization_header(TextPlain) ->
	base64:decode(TextPlain).
	
	
open_file(FilePath) ->
   {ok, PemBin2 } = file:read_file(FilePath),
    PemBin2.
	

    

    
    


