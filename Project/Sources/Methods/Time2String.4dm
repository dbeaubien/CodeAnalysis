//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: Time2String
// 
// DESCRIPTION:
//   This method converts a time to a string. The optional 2nd par
//   allows for the exact format that is required.
// ----------------------------------------------------
// PARAMETERS:
//   $1: time to convert
//   $2:  format of the date string; optional
// RETURNS:
//   $0: converted date
// ----------------------------------------------------
// MODIFICATION HISTORY:
//   Added: DB (7/14/03 @ 14:40:23)
//   Mod: DB (12/18/2009) - Better handle 12am. Show as 12am rather than 0am
// ----------------------------------------------------

C_TEXT:C284($0; $theResult)
$theResult:=""

If (DEV_ASSERT((Count parameters:C259=1) | (Count parameters:C259=2); Current method name:C684; "expecting 1 or 2 parms."))
	C_TIME:C306($1; $theTime)
	C_TEXT:C284($2; $theFormat)
	$theTime:=$1
	If (Count parameters:C259=2)
		$theFormat:=$2
	End if 
	
	If ($theFormat="")  // Default format
		$theFormat:="hh:mm ampm"
	End if 
	
	C_LONGINT:C283($timeInSeconds)
	$timeInSeconds:=$theTime+0
	
	C_LONGINT:C283($numSeconds; $timeInSeconds)
	$numSeconds:=Mod:C98($timeInSeconds; 60)
	$timeInSeconds:=$timeInSeconds-$numSeconds
	
	C_LONGINT:C283($numMinutes)
	$numMinutes:=Mod:C98($timeInSeconds; 3600)/60
	$timeInSeconds:=$timeInSeconds-($numMinutes*60)
	
	C_LONGINT:C283($num24Hours; $num12Hours)
	$num24Hours:=Mod:C98($timeInSeconds; 3600*24)/(3600)
	$num12Hours:=Mod:C98($num24Hours; 12)
	If ($num24Hours=12)
		$num12Hours:=12
	End if 
	
	C_TEXT:C284($vt_ampm)
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
	
End if   // ASSERT
$0:=$theResult