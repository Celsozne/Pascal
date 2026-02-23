unit RtpPacketizer;
{$mode objfpc}{$H+}
// Despacho por codec — zero if/else
type TPackFn = function(var ACtx: TPacketizerContext;
const AData: TBytes; APTS: Int64): TPacketList;
const PACK_DISPATCH: array[ctH264..ctH265] of TPackFn = (
@PacketizeH264, // RFC 6184 FU-A
@PacketizeH265); // RFC 7798 FU
function PacketizeFrame(var ACtx: TPacketizerContext;
const AFrame: TMediaFrame): TPacketList;
begin
Result := PACK_DISPATCH[TCodecType(ACtx.Codec)](ACtx, AFrame.Data, AFrame.PTS);
end;
end.
