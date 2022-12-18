//%attributes = {"invisible":true}
// METHOD: TS_GetDate
// $1 = Date and time in a Longint
// $0 = date

C_LONGINT:C283($1; $DateTime; $Offset)
C_DATE:C307($0)
C_DATE:C307($RefDate)

$RefDate:=!1990-01-01!
$Offset:=86400  // aka 24*60*60

$DateTime:=$1

$0:=$RefDate+Int:C8($DateTime/$Offset)
//$0:=Time(Time string($DateTime%$Offset))
