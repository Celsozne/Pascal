unit TestRtspProtocol;
{$mode objfpc}{$H+}
procedure TestParseOptions;
begin
Out := ParseRtspRequest('OPTIONS rtsp://localhost/stream RTSP/1.0'+CRLF+'CSeq: 1'+CRLF+CRLF);
Assert(Out.Status = prOK, 'Status OK');
Assert(Out.Request.Method = 'OPTIONS', 'Method');
Assert(Out.Request.CSeq = 1, 'CSeq');
end;
procedure TestSessionTransitions;
begin
Sess := NewSession('127.0.0.1', MakeRTPPort(5004), ctH264);
T := ApplyTransition(Sess, 'SETUP');
Assert(T.Valid and (T.Next = ssReady), 'Idle+SETUP->Ready');
T := ApplyTransition(Sess, 'DESCRIBE'); // inválido
Assert(not T.Valid, 'DESCRIBE invalido em Ready');
end;
end.
