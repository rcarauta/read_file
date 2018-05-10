%%
%% %CopyrightBegin%
%%
%% Copyright Hillside Technology Ltd. 2016. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%%

%% HRL file generated by ERLSOM
%%
%% It is possible (and in some cases necessary) to change the name of
%% the record fields.
%%
%% It is possible to add default values, but be aware that these will
%% only be used when *writing* an xml document.


-type anyAttrib()  :: {{string(),    %% name of the attribute
                        string()},   %% namespace
                       string()}.    %% value

-type anyAttribs() :: [anyAttrib()] | undefined.

%% xsd:QName values are translated to #qname{} records.
-record(qname, {uri :: string(),
                localPart :: string(),
                prefix :: string(),
                mappedPrefix :: string()}).



-record('wsdl:tExtensibilityElement', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined}).

-type 'wsdl:tExtensibilityElement'() :: #'wsdl:tExtensibilityElement'{}.


-record('wsdl:wsdl_port', {anyAttribs :: anyAttribs(),
	name :: string(),
	binding :: #qname{},
	documentation :: 'wsdl:documentation'() | undefined,
	choice :: [any()] | undefined}).

-type 'wsdl:wsdl_port'() :: #'wsdl:wsdl_port'{}.


-record('wsdl:service', {anyAttribs :: anyAttribs(),
	name :: string(),
	documentation :: 'wsdl:documentation'() | undefined,
	choice :: [any()] | undefined,
	port :: ['wsdl:wsdl_port'()] | undefined}).

-type 'wsdl:service'() :: #'wsdl:service'{}.


-record('wsdl:bindingOperation', {anyAttribs :: anyAttribs(),
	name :: string(),
	documentation :: 'wsdl:documentation'() | undefined,
	choice :: [any()] | undefined,
	input :: 'wsdl:bindingOperationMessage'() | undefined,
	output :: 'wsdl:bindingOperationMessage'() | undefined,
	fault :: ['wsdl:bindingOperationFault'()] | undefined}).

-type 'wsdl:bindingOperation'() :: #'wsdl:bindingOperation'{}.


-record('wsdl:bindingOperationFault', {anyAttribs :: anyAttribs(),
	name :: string(),
	documentation :: 'wsdl:documentation'() | undefined,
	choice :: [any()] | undefined}).

-type 'wsdl:bindingOperationFault'() :: #'wsdl:bindingOperationFault'{}.


-record('wsdl:bindingOperationMessage', {anyAttribs :: anyAttribs(),
	name :: string() | undefined,
	documentation :: 'wsdl:documentation'() | undefined,
	choice :: [any()] | undefined}).

-type 'wsdl:bindingOperationMessage'() :: #'wsdl:bindingOperationMessage'{}.


-record('wsdl:binding', {anyAttribs :: anyAttribs(),
	name :: string(),
	type :: #qname{},
	documentation :: 'wsdl:documentation'() | undefined,
	choice :: [any()] | undefined,
	operation :: ['wsdl:bindingOperation'()] | undefined}).

-type 'wsdl:binding'() :: #'wsdl:binding'{}.


-record('wsdl:fault', {anyAttribs :: anyAttribs(),
	name :: string(),
	message :: #qname{},
	documentation :: 'wsdl:documentation'() | undefined}).

-type 'wsdl:fault'() :: #'wsdl:fault'{}.


-record('wsdl:param', {anyAttribs :: anyAttribs(),
	name :: string() | undefined,
	message :: #qname{},
	documentation :: 'wsdl:documentation'() | undefined}).

-type 'wsdl:param'() :: #'wsdl:param'{}.


-record('wsdl:solicit-response-or-notification-operation', {anyAttribs :: anyAttribs(),
	output :: 'wsdl:param'(),
	input :: 'wsdl:param'() | undefined,
	fault :: ['wsdl:fault'()] | undefined}).

-type 'wsdl:solicit-response-or-notification-operation'() :: #'wsdl:solicit-response-or-notification-operation'{}.


-record('wsdl:request-response-or-one-way-operation', {anyAttribs :: anyAttribs(),
	input :: 'wsdl:param'(),
	output :: 'wsdl:param'() | undefined,
	fault :: ['wsdl:fault'()] | undefined}).

-type 'wsdl:request-response-or-one-way-operation'() :: #'wsdl:request-response-or-one-way-operation'{}.


-record('wsdl:operation', {anyAttribs :: anyAttribs(),
	name :: string(),
	parameterOrder :: string() | undefined,
	documentation :: 'wsdl:documentation'() | undefined,
	choice :: [any()] | undefined,
	choice1 :: 'wsdl:solicit-response-or-notification-operation'() | 'wsdl:request-response-or-one-way-operation'()}).

-type 'wsdl:operation'() :: #'wsdl:operation'{}.


-record('wsdl:portType', {anyAttribs :: anyAttribs(),
	name :: string(),
	documentation :: 'wsdl:documentation'() | undefined,
	operation :: ['wsdl:operation'()] | undefined}).

-type 'wsdl:portType'() :: #'wsdl:portType'{}.


-record('wsdl:part', {anyAttribs :: anyAttribs(),
	name :: string(),
	element :: #qname{} | undefined,
	type :: #qname{} | undefined,
	documentation :: 'wsdl:documentation'() | undefined}).

-type 'wsdl:part'() :: #'wsdl:part'{}.


-record('wsdl:message', {anyAttribs :: anyAttribs(),
	name :: string(),
	documentation :: 'wsdl:documentation'() | undefined,
	part :: ['wsdl:part'()] | undefined}).

-type 'wsdl:message'() :: #'wsdl:message'{}.


-record('wsdl:types', {anyAttribs :: anyAttribs(),
	documentation :: 'wsdl:documentation'() | undefined,
	choice :: [any()] | undefined}).

-type 'wsdl:types'() :: #'wsdl:types'{}.


-record('wsdl:import', {anyAttribs :: anyAttribs(),
	namespace :: string(),
	location :: string(),
	documentation :: 'wsdl:documentation'() | undefined}).

-type 'wsdl:import'() :: #'wsdl:import'{}.


-record('wsdl:definitions', {anyAttribs :: anyAttribs(),
	targetNamespace :: string() | undefined,
	name :: string() | undefined,
	import :: ['wsdl:import'()] | undefined,
	documentation :: 'wsdl:documentation'() | undefined,
	types :: 'wsdl:types'() | undefined,
	message :: ['wsdl:message'()] | undefined,
	portType :: ['wsdl:portType'()] | undefined,
	binding :: ['wsdl:binding'()] | undefined,
	service :: ['wsdl:service'()] | undefined}).

-type 'wsdl:definitions'() :: #'wsdl:definitions'{}.


-record('wsdl:documentation', {anyAttribs :: anyAttribs(),
	'#any' :: [any() | string()]}).

-type 'wsdl:documentation'() :: #'wsdl:documentation'{}.


-record('soap:address', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	location :: string()}).

-type 'soap:address'() :: #'soap:address'{}.


-record('soap:headerFault', {anyAttribs :: anyAttribs(),
	message :: #qname{},
	part :: string(),
	use :: string(),
	encodingStyle :: string() | undefined,
	namespace :: string() | undefined}).

-type 'soap:headerFault'() :: #'soap:headerFault'{}.


-record('soap:header', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	message :: #qname{},
	part :: string(),
	use :: string(),
	encodingStyle :: string() | undefined,
	namespace :: string() | undefined,
	headerfault :: ['soap:headerFault'()] | undefined}).

-type 'soap:header'() :: #'soap:header'{}.


-record('soap:fault', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	parts :: string() | undefined,
	encodingStyle :: string() | undefined,
	use :: string() | undefined,
	namespace :: string() | undefined,
	name :: string()}).

-type 'soap:fault'() :: #'soap:fault'{}.


-record('soap:faultRes', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	parts :: string() | undefined,
	encodingStyle :: string() | undefined,
	use :: string() | undefined,
	namespace :: string() | undefined}).

-type 'soap:faultRes'() :: #'soap:faultRes'{}.


-record('soap:body', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	parts :: string() | undefined,
	encodingStyle :: string() | undefined,
	use :: string() | undefined,
	namespace :: string() | undefined}).

-type 'soap:body'() :: #'soap:body'{}.


-record('soap:operation', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	soapAction :: string() | undefined,
	style :: string() | undefined}).

-type 'soap:operation'() :: #'soap:operation'{}.


-record('soap:binding', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	transport :: string(),
	style :: string() | undefined}).

-type 'soap:binding'() :: #'soap:binding'{}.


-record('soap12:tExtensibilityElementOpenAttrs', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined}).

-type 'soap12:tExtensibilityElementOpenAttrs'() :: #'soap12:tExtensibilityElementOpenAttrs'{}.


-record('soap12:tBinding', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	transport :: string(),
	style :: string() | undefined}).

-type 'soap12:tBinding'() :: #'soap12:tBinding'{}.


-record('soap12:tOperation', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	soapAction :: string() | undefined,
	soapActionRequired :: boolean() | undefined,
	style :: string() | undefined}).

-type 'soap12:tOperation'() :: #'soap12:tOperation'{}.


-record('soap12:tBody', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	parts :: string() | undefined,
	encodingStyle :: string() | undefined,
	use :: string() | undefined,
	namespace :: string() | undefined}).

-type 'soap12:tBody'() :: #'soap12:tBody'{}.


-record('soap12:tFaultRes', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	parts :: string() | undefined,
	encodingStyle :: string() | undefined,
	use :: string() | undefined,
	namespace :: string() | undefined}).

-type 'soap12:tFaultRes'() :: #'soap12:tFaultRes'{}.


-record('soap12:tFault', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	parts :: string() | undefined,
	encodingStyle :: string() | undefined,
	use :: string() | undefined,
	namespace :: string() | undefined,
	name :: string()}).

-type 'soap12:tFault'() :: #'soap12:tFault'{}.


-record('soap12:tHeader', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	message :: #qname{},
	part :: string(),
	use :: string(),
	encodingStyle :: string() | undefined,
	namespace :: string() | undefined,
	headerfault :: ['soap12:tHeaderFault'()] | undefined}).

-type 'soap12:tHeader'() :: #'soap12:tHeader'{}.


-record('soap12:tHeaderFault', {anyAttribs :: anyAttribs(),
	message :: #qname{},
	part :: string(),
	use :: string(),
	encodingStyle :: string() | undefined,
	namespace :: string() | undefined}).

-type 'soap12:tHeaderFault'() :: #'soap12:tHeaderFault'{}.


-record('soap12:tAddress', {anyAttribs :: anyAttribs(),
	required :: boolean() | undefined,
	location :: string()}).

-type 'soap12:tAddress'() :: #'soap12:tAddress'{}.
