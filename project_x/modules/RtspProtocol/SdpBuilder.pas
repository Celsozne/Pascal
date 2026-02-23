unit SdpBuilder;
{$mode objfpc} {$H+}

interface

uses SysUtils, NetworkType, MediaType;
type
	TSDPParams = record
		Codec: TCodecType;
		Width, Height, TrackID: Integer;
		FrameRate: Single;
		SPS, PPS, VPS, ServerIP: String;
	end;
function BuildSDP(const AParams: TSDPParams): String;

implementation
function FmtpH264(const P: TSDPParams; PT: Byte): String;
	begin
		Result := Format('a=fmtp:%d profile-level-id=42e01f;sprop-parameter-sets=%s,%s',
		[PT, P.SPS, P.PPS]);
	end;
function FmtpH265(const P: TSDPParams; PT: Byte): String;
	begin
		Result := Format('a=fmtp:%d sprop-vps=%s;sprop-sps=%s;sprop-pps=%s',
		[PT, P.VPS, P.SPS, P.PPS]);
	end;

type TFmtpFn = function(const P: TSDPParams; PT: Byte): String;
const FMTP_DISPATCH: array[ctH264..ctH265] of TFmtpFn = (@FmtpH264, @FmtpH265);
end.

