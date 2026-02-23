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
