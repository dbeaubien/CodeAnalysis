//%attributes = {"invisible":true}
// Time2String
// 
// DESCRIPTION:
//   This method converts a time to a string. The optional 2nd par
//   allows for the exact format that is required.
//
#DECLARE($theTime : Time; $theFormat : Text)->$theResult : Text
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259=1) | (Count parameters:C259=2); "expecting 1 or 2 parms.")
$theResult:=""

If ($theFormat="")  // Default format
	$theFormat:="hh:mm ampm"
End if 

var $timeInSeconds : Integer
$timeInSeconds:=$theTime+0

var $numSeconds : Integer
$numSeconds:=Mod:C98($timeInSeconds; 60)
$timeInSeconds:=$timeInSeconds-$numSeconds

var $numMinutes : Integer
$numMinutes:=Mod:C98($timeInSeconds; 3600)/60
$timeInSeconds:=$timeInSeconds-($numMinutes*60)

var $num24Hours; $num12Hours : Integer
$num24Hours:=Mod:C98($timeInSeconds; 3600*24)/(3600)
$num12Hours:=Mod:C98($num24Hours; 12)
If ($num24Hours=12)
	$num12Hours:=12
End if 

var $vt_ampm : Text
If ($num24Hours=$num12Hours) & ($num12Hours#12)
	If ($num12Hours=0)  // 0 am is really 12 am
		$num12Hours:=12
	End if 
	$vt_ampm:="am"
Else 
	$vt_ampm:="pm"
End if 

// start the conversion
$theResult:=$theFormat
$theResult:=Replace string:C233($theResult; "24hh"; String:C10($num24Hours; "00"))
$theResult:=Replace string:C233($theResult; "hh"; String:C10($num12Hours; "#0"))

$theResult:=Replace string:C233($theResult; "mm"; String:C10($numMinutes; "00"))
$theResult:=Replace string:C233($theResult; "ss"; String:C10($numSeconds; "00"))
$theResult:=Replace string:C233($theResult; "ampm"; $vt_ampm)