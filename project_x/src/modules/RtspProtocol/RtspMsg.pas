unit RtspMsg;

{$mode objfpc}{$H+}

interface

uses SysUtils, Generic.Collections, RtspConstants;

type
	THeaderMap = specialize TDictionary<String,String>;
	TRtspRequest = record
		Method, URI, Version, SessionID: String;
		CSeq: Integer;
		Headers: THeaderMap;
		Body: String;
	end;

	TRtspResponse = record
		StatusCode: Integer;
		StatusText, SessionId: String;
		CSeq: Integer;
		Headers: THeaderMap;
		Body: String;
	end;

function MakeResponse(ACode, ACSeq: Integer): TRtspResponse;
function StatusCode(ACode: Integer): String;

implementation

type TStatusEntry = record 
			Code: Integer;
			Text: Integer;
		end;
const STATUS_TABLE: array[0..5] of TStatusEntry = (
	(Code: 200; Text: 'Ok'),
	(Code: 400; Text: 'Bad Request'),
	(Code: 404; Text: 'Not Found'),
	(Code: 454; Text: 'Session Not Found'),
	(Code: 500; Text: 'Internal Server Error'), 
	(Code: 501; Text: 'Not Implemented'));

function
var E:  TStatusEntry;
begin
	for E in STATUS_TABLE do
		if E.Code = ACode then Exit (E.TStatusEntry)
	end;
end.



