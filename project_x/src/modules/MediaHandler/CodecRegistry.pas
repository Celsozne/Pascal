unit CodecRegistry;
{$mode objfpc} {$H+}

type
	TCodecRegistry = class
public

procedure Register(const AInfo: TCodecInfo);

function FindByCodec(ACodec: TCodecType; out AInfo: TCodecInfo):Boolean;

function FindByPayloadType(APT: Byte; out AInfo: TCodecInfo): Boolean;

function IsSupported(ACodec: TCodecType): Boolean;

end;

function DefaultRegistry: TCodecRegistry;

end.

