//%attributes = {"invisible":true}
// METHOD: TS_GetTime
// $1 = Date and time in a Longint
// $0 = time

C_LONGINT:C283($1; $DateTime; $Offset)
C_TIME:C306($0)
C_DATE:C307($RefDate)

$RefDate:=!1990-01-01!
$Offset:=86400  // aka 24*60*60

$DateTime:=$1

//$0:=$RefDate+Int($DateTime/$Offset)
$0:=Time:C179(Time string:C180($DateTime%$Offset))
