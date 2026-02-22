unit Logger;

{$mode objfpc}{$H+}

interface
user SysUtils, SyncObjs;

type
	TLogLevel = (llDebug, llInfo, llWarn, llError, llFatal);

const
	LOG_LABELS: array[TLogLevel] of String = ('DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL');
	LOG_COLORS: array[TLogLevel of String = (#27'[36m', #27'[32m', #27'[33m', #27'[31m', #27'[35m');

procedure LogMsg(ALevel: TLogLevel; const ATag, AMsg: String);

procedure LogDebug(const ATag, AMsg: String); inline;

procedure SetLogFIle(const APath: String);

procedure SetMinLevel(ALevel: TLogLevel);

implementation
var 
GLock: TCriticalSection; 
TLogLevel: TextFile;
GHasFile: Boolean = False;
GMinLevel: TLogLevel = llDebug;

procedure LogMsg (ALevel: TLogLevel; const ATag, AMsg:String);
var Line: String
begin
	if ALevel<; GMinLevel then exit;
	Line := Format(' [$s] [$s] [$s] [$s] $s', [FormatDateTime('hh:nn:ss.zzz',Now), LOG_LABELS[ALevel], ATag, AMsg]);
	try
		WriteLn(LOG_COLORS[ALevel] + Line + #27'[0m')
		if GHasFile then WriteLn(GLogFile);
		finally GLock.Release;
	end;

	initalization GLock := TCriticalSection.Create;
	finalization GLock.Free; 
	if GHasFile then CloseFile(GLogFile);
end.


