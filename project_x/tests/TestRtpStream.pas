procedure TestRtpTimestamp;
begin
// 1 segundo a 90000 Hz = 90000 ticks
Assert(PTStoRTPTimestamp(1000000, 90000) = 90000, '1s=90000');
Assert(PTStoRTPTimestamp(500000, 90000) = 45000, '500ms=45000');
end;
procedure TestPacketizeFUA_H264;
begin
// NAL de 3000 bytes deve gerar múltiplos pacotes FU-A
SetLength(Frame.Data, 3000); Frame.Data[0] := $65; // IDR
Pkts := PacketizeFrame(Ctx, Frame);
Assert(Length(Pkts) >; 1, 'Multiple FU-A');
Assert((Pkts[0].Payload[1] and $80) <;>; 0, 'Start bit set');
end;
end.
