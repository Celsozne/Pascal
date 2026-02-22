procedure TestCodecRegistryLookup;
begin
Reg := DefaultRegistry;
Assert(Reg.IsSupported(ctH264), 'H264 supported');
Assert(Reg.IsSupported(ctH265), 'H265 supported');
Assert(Reg.FindByPayloadType(96, Info), 'Find by PT 96');
Assert(Info.Codec = ctH264, 'PT96=H264');
end;
procedure TestFFmpegReadFrame;
begin
OpenMedia('media/sample.mp4', Ctx);
for I := 1 to 10 do
Assert(ReadNextFrame(Ctx, Frame) = brOK, Format('Frame %d',[I]));
CloseMedia(Ctx);
end;
end.
