unit VideoEncoder;
{$mode objfpc}{$H+}
type TEncoderMode = (emPassthrough, emReencode);
// Despacho por modo — sem if/else
const ENCODER_DISPATCH: array[TEncoderMode] of TEncoderFn = (
@PassthroughFrame, @ReencodeFrame);
function TVideoEncoder.ProcessFrame(const AIn: TMediaFrame;
out AOut: TMediaFrame): Boolean;
begin Result := ENCODER_DISPATCH[FMode](AIn, AOut); end;
end.
