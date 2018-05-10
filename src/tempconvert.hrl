
%% generated by soap from: /home/rcarauta/desenvolvimento/erlang/soap/ebin/tempconvert.wsdl
%% for service "TempConvert" and port "TempConvertSoap12"
%% using options: [{service,"TempConvert"},{port,"TempConvertSoap12"},{generate,both},{namespaces,[{"https://www.w3schools.com/xml/","P0"}]},{generate_tests,none},{http_server,soap_server_cowboy_2},{server_name,"tempconvert_server"},{http_client,soap_client_ibrowse},{client_name,"tempconvert_client"},{strict,true}]

%%% This file contains record and type decarations that are used by the WSDL.
%%%
%%% It also contains a macro 'INTERFACE' that is used to make information
%%% about the WSDL available to the SOAP implementation.
%%%
%%% It is possible (and in some cases necessary) to change the name of the
%%% record fields.
%%%
%%% It is possible to add default values, but be aware that these will only
%%% be used when *writing* an xml document.

%%% Records used to represent fault response messages:

-record(faultdetail, {uri :: string(),
                      tag :: string(),
                      text :: string()}).

-record(faultcode, {uri :: string(),
                    code :: string(),
                    subcode :: #faultcode{} % only v. 1.2
                   }).

-record(faultreason, {text :: string(),
                      language :: string()}).

-record(soap_fault_1_1, {faultcode :: #faultcode{},
                         faultstring :: string(),
                         faultactor :: string(),
                         detail :: [#faultdetail{}]}).

-record(soap_fault_1_2, {code :: #faultcode{},
                         reason :: [#faultreason{}],
                         role :: string(),
                         detail :: [#faultdetail{}]}).

%% xsd:QName values are translated to #qname{} records.
-record(qname, {uri :: string(),
                localPart :: string(),
                prefix :: string(),
                mappedPrefix :: string()}).



-record('P0:string', {
	string :: string()}).

-type 'P0:string'() :: #'P0:string'{}.


-record('P0:CelsiusToFahrenheitResponse', {
	'CelsiusToFahrenheitResult' :: string() | undefined}).

-type 'P0:CelsiusToFahrenheitResponse'() :: #'P0:CelsiusToFahrenheitResponse'{}.


-record('P0:CelsiusToFahrenheit', {
	'Celsius' :: string() | undefined}).

-type 'P0:CelsiusToFahrenheit'() :: #'P0:CelsiusToFahrenheit'{}.


-record('P0:FahrenheitToCelsiusResponse', {
	'FahrenheitToCelsiusResult' :: string() | undefined}).

-type 'P0:FahrenheitToCelsiusResponse'() :: #'P0:FahrenheitToCelsiusResponse'{}.


-record('P0:FahrenheitToCelsius', {
	'Fahrenheit' :: string() | undefined}).

-type 'P0:FahrenheitToCelsius'() :: #'P0:FahrenheitToCelsius'{}.
-define(INTERFACE, {interface,"TempConvert",tempconvert,'1.2',
                    soap_client_ibrowse,soap_server_cowboy_2,
                    tempconvert_server,tempconvert_client,[],
                    "https://www.w3schools.com/xml/",
                    "http://www.w3.org/2003/05/soap-envelope",undefined,
                    undefined,"http://www.w3schools.com/xml/tempconvert.asmx",
                    "TempConvertSoap12","TempConvertSoap12","TempConvertSoap",
                    [{op,"FahrenheitToCelsius",'FahrenheitToCelsius',[],
                      undefined,request_response,'P0:FahrenheitToCelsius',
                      'P0:FahrenheitToCelsiusResponse',undefined},
                     {op,"CelsiusToFahrenheit",'CelsiusToFahrenheit',[],
                      undefined,request_response,'P0:CelsiusToFahrenheit',
                      'P0:CelsiusToFahrenheitResponse',undefined}],
                    {model,
                     [{type,'_document',sequence,
                       [{el,
                         [{alt,'P0:FahrenheitToCelsius',
                           'P0:FahrenheitToCelsius',[],1,1,true,undefined},
                          {alt,'P0:FahrenheitToCelsiusResponse',
                           'P0:FahrenheitToCelsiusResponse',[],1,1,true,
                           undefined},
                          {alt,'P0:CelsiusToFahrenheit',
                           'P0:CelsiusToFahrenheit',[],1,1,true,undefined},
                          {alt,'P0:CelsiusToFahrenheitResponse',
                           'P0:CelsiusToFahrenheitResponse',[],1,1,true,
                           undefined},
                          {alt,'P0:string','P0:string',[],1,1,simple,
                           undefined}],
                         1,1,undefined,2}],
                       [],undefined,undefined,1,1,1,false,undefined},
                      {type,'P0:string',sequence,
                       [{el,
                         [{alt,'P0:string',
                           {'#PCDATA',char},
                           [],1,1,true,undefined}],
                         1,1,undefined,2}],
                       [],undefined,undefined,2,1,1,false,undefined},
                      {type,'P0:CelsiusToFahrenheitResponse',sequence,
                       [{el,
                         [{alt,'P0:CelsiusToFahrenheitResult',
                           {'#PCDATA',char},
                           [],1,1,true,undefined}],
                         0,1,undefined,2}],
                       [],undefined,undefined,2,1,1,undefined,undefined},
                      {type,'P0:CelsiusToFahrenheit',sequence,
                       [{el,
                         [{alt,'P0:Celsius',
                           {'#PCDATA',char},
                           [],1,1,true,undefined}],
                         0,1,undefined,2}],
                       [],undefined,undefined,2,1,1,undefined,undefined},
                      {type,'P0:FahrenheitToCelsiusResponse',sequence,
                       [{el,
                         [{alt,'P0:FahrenheitToCelsiusResult',
                           {'#PCDATA',char},
                           [],1,1,true,undefined}],
                         0,1,undefined,2}],
                       [],undefined,undefined,2,1,1,undefined,undefined},
                      {type,'P0:FahrenheitToCelsius',sequence,
                       [{el,
                         [{alt,'P0:Fahrenheit',
                           {'#PCDATA',char},
                           [],1,1,true,undefined}],
                         0,1,undefined,2}],
                       [],undefined,undefined,2,1,1,undefined,undefined}],
                     [{ns,"http://www.w3.org/2001/XMLSchema","xsd",qualified},
                      {ns,"https://www.w3schools.com/xml/","P0",qualified}],
                     "https://www.w3schools.com/xml/",[],false,skip},
                    1,undefined,
                    [{"https://www.w3schools.com/xml/","P0"}]}).
