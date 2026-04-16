//%attributes = {"invisible":true,"preemptive":"capable"}
// TS_FromDateTime (..)
//
#DECLARE($Date : Date; $Time : Time)->$ts : Integer
// ----------------------------------------------------
$ts:=0

var $Offset : Integer
var $RefDate : Date
$RefDate:=!1990-01-01!
$Offset:=86400  // aka 24*60*60

Case of 
	: (Count parameters:C259=0)  // Get the date and time on the server
		$Date:=Current date:C33
		$Time:=Current time:C178
		
	: (Count parameters:C259=1)  // Get the time on the server
		$Time:=Current time:C178
		
End case 

If ($date#!00-00-00!)
	$ts:=($Date-$RefDate)*$Offset
	$ts+=($Time+0)
End if 
