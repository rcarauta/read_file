# read_file

Run Application 

1 - use command rebar get-deps

2 - use comand rebar compile

3 - use command erl -pa ebin/ -pa deps/*/ebin/

4 - inside erl terminal use foo:start().

Opcionais:

   Iniciar os serviços rest:
     
     	1- no console digitar o comando read_catalog:read_all_files_Folder().

     	2 - acessar o servico /home na porta 8081.

   Consultar cep web service correios:

	1 - usar o comando: rr("~/desenvolvimento/erlang/read_file/src/cprreios.hrl").
	
	2 - Consultar o cep: correios_client:'consultaCEP'(#'P0:consultaCEP'{'cep' = "70040912"},[],[]).

	3 - O resultado será retornado pelo serviço soap dos correios.
