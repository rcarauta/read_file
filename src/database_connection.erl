-module(database_connection).

-include("tables.hrl").

-include_lib("stdlib/include/qlc.hrl").

-export([initiate_connection/1,start/0, start_mnesia/0, create_all_tables/0]).

%% database_connection:initiate_connection("Driver={MySQL ODBC 5.1 Driver};Server=localhost;Database=algamoney;User=root;Password=travian10;").

start() ->
    odbc:start().

initiate_connection(Connection) ->
    Result = odbc:connect(Connection,[]),
    io:format("Conection ok ...  ~p ~n",[Result]).

start_mnesia() ->
    mnesia:create_schema([node()]),
    mnesia:start().

create_all_tables() ->
    mnesia:create_table(employee,[{attributes, record_info(fields, employee)}]).