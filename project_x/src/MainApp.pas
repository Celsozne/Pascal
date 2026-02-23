program MainApp;
{$mode objfpc}{$H+}
uses SysUtils, ConfigLoader, Logger,
FFmpegBridge, MediaDemuxer, VideoEncoder, TcpServer;
var Config: TServerConfig; Ctx: TFFmpegContext;
Demuxer: TMediaDemuxer; Server: TTcpServer;
begin
Config := LoadConfig('config/server.ini');
SetLogFile(Config.LogPath);
OpenMedia(Config.MediaPath, Ctx);
Demuxer := TMediaDemuxer.Create(Config.MediaPath, True);
Server := TTcpServer.Create(Config, SDP);
Server.Start;
WriteLn('rtsp://localhost:554/stream');
ReadLn;
Server.Stop;
end.
