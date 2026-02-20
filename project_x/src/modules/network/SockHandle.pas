unit SockHandle;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Sockets, NetTypes;

type
  SocketHandle = class
    private
      FsocketHandle: tsocket_handle;
      FClientEndpoint: Endpoint;
      FDataReceived: DataReceived;
      FDisconnect: Disconnectevent;
      IsConnected: Boolean;
      FReadBuffer: Tbytes;
      FBufferSize: Integer;

    procedure SetSocketHandle(const Value: tsocket_handle);
    procedure SetClientEndpoint(const Value: Endpoint);
    procedure SetDataReceived(const Value: DataReceived);
    procedure SetOnDisconnect(const Value: Disconnectevent);


    public
      constructor  Create(ASocketHandle: tsocket_handle; AClientEndpoint: Endpoint; FBufferSize: Integer = 4096);
      destructor Destroy; Override;

    (*Inicia a escuta de dados no socket*)
    procedure StartListening;
    (*o socket para de escutar*)
    procedure StopListening;
    (*Envia os dados pelo socket*)
    procedure SendData;
    (*Manda uma string *)
    procedure SendString;

    (*Propriedades de leitura*)
    property SocketHandle: tsocket_handle read FsocketHandle;
    property ClientEndpoint: Endpoint read FClientEndpoint;
    property IsConnected: Boolean read FDisconnect;

    (*Eventos que serao atribuidos em outros modulos*)
    property OneDataReceived: DataReceived read FDataReceived write SetDataReceived;
    property OnDisconnect: Disconnectevent read FDisconnect write SetOnDisconnect;

  end;


implementation

{ tsocket_handle }

constructor tsocket_handle.Create(ASocketHandle: tsocket_handle; AClientEndpoint: TNetworkEndpoint; FBufferSize: Integer = 4096);
  begin
    inherited Create;
    FsocketHandle := ASocketHandle;
    FClientEndpoint := AClientEndpoint;
    FBufferSize := BufferSize;
    Setlength(FReadBuffer, FBufferSize);
    IsConnected := True; (*Assumimnos que o socket já esta conectado ao ser criado*)
  end

  destructor tsocket_handle.Destroy;
  begin
    StopListening; (*Fecha o socket*)
    inherited Destroy;
  end;

  procedure tsocket_handle.SetSocketHandle(const Value: tsocket_handle);
  begin
    FsocketHandle := Value;
  end;

  procedure tsocket_handle.SetClientEndpoint(const Value: Endpoint);
  begin
    FClientEndpoint := Value;
  end;

  procedure tsocket_handle.SetDataReceived(const Value: DataReceived);
  begin
    FDataReceived := Value;
  end;

  procedure tsocket_handle.SetOnDisconnect(const Value: Disconnectevent);
  begin
    FDisconnect := Value;
  end;

  procedure tsocket_handle.StartListening;

  var
    BytesReceived: Integral;
  begin
    (*TODO: tornar isso paralelo para não travar a thread*))

    while IsConnected do
      begin
        try
          BytesReceiveed := Sockets.Recv(FsocketHandle, FReadBuffer,FBufferSize, BytesReceived);
            if BytesReceived > 0 then
            (*Notifica o evento de dados recebidos*)
            begin
              FDataReceived(FsocketHandle, FReadBuffer, BytesReceived);
            end
            else if BytesReceived = 0 then
              begin
                IsConnected := False
                if Assigned(FDisconnect) then
                  FDisconnect(FsocketHandle);
              end
              else
                begin
                  (*Se der erro com BytesReceived<0*)
                  IsConnected := False;
                  if (Sockets.GetLastError <> Sockets.EWOULDBLOCK) and (Sockets.GetLastError <> Sockets.EINPROGRESS) then
                    begin
                      IsConnected := False;
                      if Assigned(FDisconnect) then
                        FDisconnect(FsocketHandle);
                      raise ENetworError.CreateFmt('Socket error during receive: %d', [Socket.GetLastError]);

                    end;
                end;
        except
          on E: Exception do
            begin
              Writeln(Format('Error in SocketHandler for %s:%d: %s', [FClientEndpoint.IP, FClientEndpoint.Port, E.Message]));
                     FIsConnected := False;
                     if Assigned(FOnDisconnect) then
                       FOnDisconnect(FSocketHandle);
            end;
          Sleep(10);
        end;
      end;
      procedure TSocketHandler.StopListening;
      begin
        if FIsConnected then
        begin
          FIsConnected := False;
          (*Fecha o socket. Sockets.CloseSocket é a função correta.*)
          Sockets.CloseSocket(FSocketHandle);
          FSocketHandle := INVALID_SOCKET; (*Marca como inválido*)
        end;
      end;

      procedure TSocketHandler.SendData(const ABuffer: TBytes): Integer;
      var
        BytesSent: Integer;
      begin
        Result := 0;
        if not FIsConnected then
          raise ENetworkError.Create('Cannot send data: socket is not connected.');

        try
          BytesSent := Sockets.Send(FSocketHandle, ABuffer[0], Length(ABuffer), 0);
          if BytesSent < 0 then
            raise ENetworkError.CreateFmt('Error sending data: %d', [Sockets.GetLastError]);
          Result := BytesSent;
        except
          on E: Exception do
          begin
            Writeln(Format('Error sending data to %s:%d: %s', [FClientEndpoint.IP, FClientEndpoint.Port, E.Message]));
            FIsConnected := False; (*Assume desconexão em caso de erro de envio*)
            if Assigned(FOnDisconnect) then
              FOnDisconnect(FSocketHandle);
            raise; (*Relança a exceção*)
          end;
        end;
      end;

      procedure TSocketHandler.SendString(const AText: string): Integer;
      var
        Bytes: TBytes;
      begin
        Bytes := TEncoding.UTF8.GetBytes(AText); (*Converte a string para bytes (UTF8 é uma boa escolha para rede*)
        Result := SendData(Bytes);
      end;

      end.
