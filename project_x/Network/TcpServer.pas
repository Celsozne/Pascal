RTSP Server Project — Guia Completo de Implementação Pascal / Lazarus + FFmpeg
H.264 · H.265/HEVC · Funções Puras · Despacho por Tabela Página 17
Network/TcpServer.pas [Network]
n Teste: Aceitar 3 conexões simultâneas em threads separadas
n Por quê: Ponto de entrada de rede. Testado após SocketHandler validado.
Servidor TCP porta 554. Aceita conexões, delega para TSocketHandler.
Código:
unit TcpServer;
{$mode objfpc}{$H+}
type
TTcpServer = class
public
function Start: Boolean;
procedure Stop;
end;
procedure TTcpServer.AcceptLoop;
begin
ClientSock := fpAccept(FListenSock, @ClientAddr, @AddrLen);
Handler := TSocketHandler.Create(ClientSock, Addr, FSDPParams);
Handler.Start;
end;
end.
