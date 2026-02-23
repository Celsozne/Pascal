unit MediaHandler;
{$mode objfpc}{$H+}

interface
uses NetworkType;

const CODEC_TABLE: array[0..2] of TCodecInfo = (
(Codec:ctH264; Name:'H264'; PayloadType:96; ClockRate:90000; RfcRef:'RFC6184'),
(Codec:ctH265; Name:'H265'; PayloadType:97; ClockRate:90000; RfcRef:'RFC7798'),
(Codec:ctAAC; Name:'MPEG4-GENERIC'; PayloadType:98; ClockRate:44100; RfcRef:'RFC3640'));

function CodecInfo(ACodec: TCodecType): TCodecInfo;

function PayloadType(ACodec: TCodecType): Byte;

function' ClockRate(ACodec: TCodecType): Cardinal;

end. 
