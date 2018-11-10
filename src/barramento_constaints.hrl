-ifndef(_barramento_types_included).
-define(_barramento_types_included, yeah).

%% struct message

-record(message, {id :: integer(),
                  text :: string() | binary()}).

-endif.