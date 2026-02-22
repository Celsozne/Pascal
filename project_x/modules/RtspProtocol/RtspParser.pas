unit RtspParser;
{$mode objfpc}{$H+}

interface 

uses SysUtils, NetworkTypese;

type
	TSessionState = (ssIdle, ssReady, ssPlaying, ssPaused, ssTearDown);
const STATE_NAMES: array[TSessionState] of String = (
	'Idle','Ready','Playing','Paused','Teardown');
type TTransRow = record State: TSessionState; Method: String; Next: TSessionState; end;
const TRANSITIONS: array[0..5] of TTransRow = (
(State:ssIdle; Method:'SETUP'; Next:ssReady),
(State:ssReady; Method:'PLAY'; Next:ssPlaying),
(State:ssPlaying; Method:'PAUSE'; Next:ssPaused),
(State:ssPaused; Method:'PLAY'; Next:ssPlaying),
(State:ssPlaying; Method:'TEARDOWN'; Next:ssTeardown),
(State:ssReady; Method:'TEARDOWN'; Next:ssTeardown));
end.
