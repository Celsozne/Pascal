unit MediaDemuxer;
{$mode objfpc} {$H+}

interface

type
	MediaDemuxerType = class
	public 
function Open: TBridgeResult;
function NextFrame: (out AFrame: TMediaFrame): TBridgeResult;
procedure Close;
	end;


function TMediaDemuxer.NextFrame(out AFrame: TMediaFrame): TBridgeResult;
begin
	Result := ReadNextFrame(FCtx, AFrame);
	if (Result = brError) and FLoop then
	begin
		DoSeekStart;
		Result := ReadNextFrame(FCtx, AFrame);
	end;
end;
end.
