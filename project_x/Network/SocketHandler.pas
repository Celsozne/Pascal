RTSP Server Project — Guia Completo de Implementação Pascal / Lazarus + FFmpeg
H.264 · H.265/HEVC · Funções Puras · Despacho por Tabela Página 16
FASE 5 — Rede — TCP / UDP
22. UdpSender.pas
Network/UdpSender.pas [Network]
n Teste: Enviar datagrama UDP para 127.0.0.1 e confirmar recepção
n Por quê: RtpSender depende deste socket. Testado isoladamente.
Wrapper de socket UDP. Abstrai diferenças Win/Linux.
Código:
unit UdpSender;
{$mode objfpc}{$H+}
type
TUDPSocket = class
public
function Open: Boolean;
function SendTo(const AHost: String; APort: Word; const AData: TBytes): Integer;
procedure Close;
end;
end.
23. SocketHandler.pas
Network/SocketHandler.pas [Network]
n Teste: Receber RTSP via TCP; invocar parser; enviar resposta
n Por quê: Gerencia ciclo de vida de uma conexão TCP individual.
Handler de conexão TCP. Recebe dados, invoca RTSP, envia resposta.
Código:
unit SocketHandler;
{$mode objfpc}{$H+}
type
TSocketHandler = class(TThread)
private
FSock: Integer; FClientAddr: TSocketAddress; FCtx: THandlerContext;
protected
procedure Execute; override;
end;
procedure TSocketHandler.Execute;
var Raw: String; Parsed: TParserOutput; Resp: TRtspResponse;
begin
while not Terminated do begin
if not ReceiveRequest(Raw) then Break;
Parsed := ParseRtspRequest(Raw);
Resp := HandleRequest(Parsed.Request, FCtx);
SendResponse(Resp);
if FCtx.Session.State = ssTeardown then Break;
end;
end;
end.
