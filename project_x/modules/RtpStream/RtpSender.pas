RTSP Server Project — Guia Completo de Implementação Pascal / Lazarus + FFmpeg
H.264 · H.265/HEVC · Funções Puras · Despacho por Tabela Página 15
Código:
unit RtpSessionContext;
{$mode objfpc}{$H+}
type
TRtpSessionContext = record
SessionID : String;
PackCtx : TPacketizerContext;
ClientAddr : TSocketAddress;
RTPPort : TRTPPort;
Active : Boolean;
end;
end.
21. RtpSender.pas
Modules/RtpStream/RtpSender.pas [RtpStream]
n Teste: Enviar 30 pacotes RTP via UDP para loopback; verificar com tcpdump
n Por quê: Último elo do pipeline antes da integração com o servidor.
Loop de envio RTP via UDP. Controla timing baseado em framerate.
Código:
unit RtpSender;
{$mode objfpc}{$H+}
type
TRtpSender = class(TThread)
public
procedure Stop;
end;
// Loop principal de envio
procedure TRtpSender.Execute;
var Frame, Encoded: TMediaFrame; Packets: TPacketList;
begin
while not FStop do begin
if FDemuxer.NextFrame(Frame) <;>; brOK then Continue;
if not FEncoder.ProcessFrame(Frame, Encoded) then Continue;
Packets := PacketizeFrame(FContext.PackCtx, Encoded);
SendPackets(Packets);
SleepForFramerate(FDemuxer.Context.Framerate);
end;
end;
end.
