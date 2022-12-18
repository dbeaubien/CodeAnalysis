//%attributes = {"invisible":true,"preemptive":"capable"}
// METHOD: TS_FromDateTime
// $0 = Date and time put into a Longint
// $1 = Date
// $2 = Time

C_LONGINT:C283($0; $Offset)
C_DATE:C307($1; $Date; $RefDate)
C_TIME:C306($2; $Time)
$RefDate:=!1990-01-01!
$Offset:=86400  // aka 24*60*60

Case of 
	: (Count parameters:C259=0)  // Get the date and time on the server
		$Date:=Current date:C33
		$Time:=Current time:C178
		
	: (Count parameters:C259=1)  // Get the time on the server
		$Date:=$1
		$Time:=Current time:C178
		
	: (Count parameters:C259=2)  // The date and time were both passed to this routine
		$Date:=$1
		$Time:=$2
End case 

If ($date#!00-00-00!)
	$0:=($Date-$RefDate)*$Offset
	$0:=$0+($Time+0)
Else 
	$0:=0  // no date means a zero
End if 
