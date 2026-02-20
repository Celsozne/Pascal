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
		Clientconnectevent = procedure(
		SocketHandle: SocketHandle; 
			const
			       Buffer: Byte;
			       Bytesreceived: Integer
			       ) of object;



		(*Delegate pra desconexao e vai ser usado pelo handler e server*)	       
		Disconnectevent = procedure(SocketHandle: SocketHandle) of object;
			       	       


