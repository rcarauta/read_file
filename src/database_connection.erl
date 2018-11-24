-module(database_connection).

-include("tables.hrl").

-include_lib("stdlib/include/qlc.hrl").

-export([initiate_connection/1,start/0, start_mnesia/0, create_all_tables/0, insert/1, find_all/1]).

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
    mnesia:create_table(employee,[{attributes, record_info(fields, employee)}]),
	mnesia:create_table(user,[{attributes, record_info(fields, user)}]),
	mnesia:create_table(client,[{attributes, record_info(fields, client)}]).


insert(Record) ->
	RecordType = element(1, Record),
	insert(RecordType, Record).


insert(RecordType, Record) ->
	F = fun() ->
		case element(2, Record) of
			undefined ->
				Id = sequence(RecordType),
				Record1 = setelement(2, Record, Id),
				mnesia:write(Record1),
				Record1;
			Id -> 
				case mnesia:read(RecordType, Id) of
					[] -> mnesia:write(Record),
						  Record;
					_ -> {error, ealready_exist}
				end
		end
	end,		
	case mnesia:transaction(F) of
		{atomic, Result} -> {ok, Result};
		Error -> Error
	end.



find_all(Tab) ->
	F = fun() ->
		  qlc:e(
			 qlc:q([X || X <- mnesia:table(Tab)])
		  )
	   end,
	Records = mnesia:activity(async_dirty, F),
	{ok, Records}.


sequence(Name) ->  
    mnesia:dirty_update_counter(sequence, Name, 1).
