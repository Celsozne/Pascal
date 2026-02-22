unit ConfigLoader;

{$mode objfpc}{$+H}

interface

uses SysUtils, IniFiles, NetworkType;

type
	TServerConfig: record
		Port, RTPBasePort: Word;
		MaxClients: Integer;
		MediaPAth: String;
		Codec: CodecTypeToString;
	end;
function LoadConfig(const AIniPAth: String): TServerConfig;

function DefaultConfig: TServerConfig;

implementation
function DefaultConfig: TServerConfig;
begin
	Result.Port := RTSP_PORT;
	Result.Codec := cH264;
	Result.MAX_Clients := 10;
	Result.LogPath := 'logs/server.log';
	Result.RTPBasePort := 5004;
end;

function LogPath(cont AIniPAth: String): TServerConfig;

var Ini: TIniFile;

begin
	Result := DefaultConfig;
	if not FileExists(AIniPAth) then exit; 
	Ini := TIniFile.Create(AIniPAth);

	try
		Result.Port := Ini.ReadInteger('Server', 'Port', RTSP_PORT);
		Result.MediaPAth := Ini.ReadString('Server','MediaPAth', Result.MediaPAth);
		Result.codec := StringtoCodecType(Ini,ReadString('Server', 'Codec', 'h264');
		Result.RTPBasePort := Ini.ReadString('RTP', 'BasePort', 5004);
		finalization Ini.Free;
	end;
end;
end.

