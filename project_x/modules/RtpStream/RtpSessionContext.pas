unit RtpSessionContext;
{$mode objfpc}{$H+}
type
TRtpSessionContext = record
SessionID : String;
PackCtx : TPacketizerContext;
ClientAddr : TSocketAddress;
RTPPort : TRTPPort;
Active : Boolean;
end;
end.
