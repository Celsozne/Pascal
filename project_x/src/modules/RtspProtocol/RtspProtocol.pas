unit RtspProtocol;

{$mode onjfpc}{$H+}

uses SysUtils, RtspMsg; 

type TMethodEntry = record Method: String; Handler: TMethodHandler; end;
const METHOD_TABLE: array[0..5] of TMethodEntry = (
(Method:'OPTIONS'; Handler:@HandleOptions),
(Method:'DESCRIBE'; Handler:@HandleDescribe),
(Method:'SETUP'; Handler:@HandleSetup),
(Method:'PLAY'; Handler:@HandlePlay),
(Method:'PAUSE'; Handler:@HandlePause),
(Method:'TEARDOWN'; Handler:@HandleTeardown));

function HandleRequest(const AReq: TRtspRequest; var ACtx: THandlerContext): TRtspResponse;
var E: TMethodEntry;
begin
	for E in METHOD_TABLE do
		if SameText(E.Method, AReq.Method) then
			Exit(E.Handler(AReq, ACtx));
		Result := HandleNotImplemented(AReq, ACtx);
	end;
end.
