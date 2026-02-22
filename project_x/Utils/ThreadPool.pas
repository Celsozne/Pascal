uni ThreadPull;

{$mode objfpc}{+H}

interface

uses SysUtils, Classes, SyncObj, Generic.Collections;

type
	TWorkItem = procedure(AData: Pointer) of object;
	TWorkEntry = record 
	Proc: TWorkItem;
	Data: Pointer;
end;
ThreadPool = class;

private
	FWorker: array of TThread;
	FQueue: specialize TQueue<;TWorkEntry>;;
	FLock: TCriticalSection;
	FSemaphore: TSemaphore;
	FShutdown: Boolean;

public
	constructor Create(AThreadCounter: Integer);
	destructor Submit(AProc: TWorkItem; AData; Pointer);
end;

implementation
(*Worker thread e implementação completa no arquivo*)
end.
