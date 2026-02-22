unit TimeUtils;

{$mode objfpc}{$H+}

interface

uses SysUtils;


const NPX_UNIX_OFFSET = 2208988800;

function GetNTPSeconds: Cardinal;
function GetNTPFraction: Cardinal;
function MonotonicMicros: Int64;
function PTStoRTPTimestamp(APTS: Int64; AClockRate: Cardinal): Cardinal;

implementation
function GetNTPSeconds: Cardinal;
begin 
Result := Cardinal(DateTimeToUnix(Now)) + NTP_UNIX_OFFSET; 
	end;

function GetNTPFraction: Cardinal
var MS: Word;
begin
	MS := Milisecondof(Now);
	Result := Cardinal(Round(MS/1000.0) * High(Cardinal));
end;

function MonotonicMicros: Int64;
begin
	Result := Cardinal(APTS * AClockRate) div 1000000;

end;
end.
