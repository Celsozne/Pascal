unit SockHandle;

uses
  Classes, SysUtils, Sockets, NetTypes;

type
  SocketHandle = class
    private
      FsocketHandle: tsocket_handle;
      FClientEndpoint: Endpoint;
      FDataReceived: Datareceived
  end;
