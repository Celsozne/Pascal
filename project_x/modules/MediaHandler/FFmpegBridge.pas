unit FFmpegBridge;
{$mode objfpc}{$H+}

interface
uses NetworkType;

type TCodecMapEntry = record
	FFMpegID: Integer;
	Codec: TCodecType;
end;

const CODEC_MAP: array[0..1] of TCodecMapEntry = (
(FFmpegID:27; Codec:ctH264), 
(FFmpegID:173; Codec:ctH265));

function FFMpegIDtoCodec(AID:Integer): TCodecType;
var E: TCodecMapEntry;
begin 
Result := ctUnknown;
for E  in CODEC_MAP do 
if E.FFMpegID = AID then exit(E.Codec);
		end;
end.

