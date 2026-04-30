//%attributes = {"invisible":true}
// METHOD: TS_GetTime
// $1 = Date and time in a Longint
// $0 = time

#DECLARE($DateTime : Integer) : Time

var $Offset : Integer
var $RefDate : Date
$RefDate:=!1990-01-01!
$Offset:=86400  // aka 24*60*60

return Time:C179(Time string:C180($DateTime%$Offset))