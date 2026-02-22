program TestRunner;
{$mode objfpc}{$H+}
uses SysUtils, TestRtspProtocol, TestRtpStream, TestMediaHandler;
procedure Run(const AName: String; AProc: TProcedure);
begin
Inc(Total); Write(Format(' %-44s ',[AName]));
try AProc; Inc(Passed); WriteLn('[ OK ]');
except on E: Exception do begin Inc(Failed); WriteLn('[FAILED] '+E.Message); end; end;
end;
end.
