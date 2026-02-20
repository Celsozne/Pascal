unit NetTypes;

{$mode objfpc}{$H+}


interface

	uses
		Classes, SysUtils, Sockets; (*Unidades do fpc pra operações...*)

	type
		(*Type para ser um socket handle<arquivo/socket>*)
		tsocket_handle = Tsocket;

		(*Tipo IP*)
		IPaddress = string;

		(*Tipo porta*)
		Port = Word;(*u16*)

		(*Enum state*)
		SocketState = (Sdisconnected, Sconnecting, Sconnected, Slistening);

		(*Armazenamento da IP/Porta como endpoint*)
		Endpoint = record
			IP: IPaddress;
			Port: Port;
		end;


		(*Procedimento(delegate) para eventos de novas conexoes*)
		(*Vai ser utilizado pelo server para notificar o q chega*)
		Connectevent =procedure(SocketHandle: tsocket_handle; CEndpoint: Endpoint) of object;


		DataReceived = procedure(
		SocketHandle: SocketHandle;
			const
			       Buffer: Byte;
			       Bytesreceived: Integer
			       ) of object;


		(*Delegate pra desconexao e vai ser usado pelo handler e server*)
		Disconnectevent = procedure(SocketHandle: SocketHandle) of object;


	  (*Except para pegar erros*)
		Networkerror = class(Exception)
		  public
				constructor Create(const Msg:string); overload;
				constructor CreateFMT(
				const Msg: string;
				const Args: array of const;
				); overload;
		end;

	implementation
	  { Networkerror }
			constructor Networkerror.Create(const Msg:string);
			begin
			  inherited Create(Msg);
			end;

			constructor Networkerror.CreateFMT(Msg: string;
			const Args: array of const
			);
			begin
			  inherited CreateFMT(Msg,Args)
			end;

			end.
