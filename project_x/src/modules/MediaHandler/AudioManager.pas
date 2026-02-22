unit AudioMAanger;

{$mode objfpc}{$H+}

type
	TAudioManager = class
public
function AttachContext(var ACtx: TFFmpegContex): Boolean;
funciot NextAudioFrame(out AFrame: TMediaFrame): TBridgeResult;
		end;
end.

