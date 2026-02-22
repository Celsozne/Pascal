unit RtpTypes;
{$mode objfpc} {$H+}

type
	TRTPHeader = packed record
		Flags1, Flags2: Byte;
		SeqNum: Word;
		TimeStamp, SSRC: Cardinal;
	end;
function MakeRTPHeader(APayloadType: Byte; ASeq: Word; AFTimeStamp: ASSRC: Cardinal; AMarker: Boolean): TRTPHeader;

function SwapWord(AVal: Word): Word; inline;

function SwapDWord(AVal: Cardinal): Cardinal; inline;

function SerializeRTPPacket(const APkt: TRTPHeader): TBytes;

end.

