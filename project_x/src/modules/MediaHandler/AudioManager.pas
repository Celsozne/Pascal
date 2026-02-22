unit AudioMAanger;

{$mode objfpc}{$H+}

type
	TAudioManager = class
public
function AttachContext(var ACtx: TFFmpegContex): Boolean;
function NextAudioFrame(out AFrame: TMediaFrame): TBridgeResult;
		end;
end.

