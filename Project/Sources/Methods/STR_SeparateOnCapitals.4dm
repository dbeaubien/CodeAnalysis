//%attributes = {"invisible":true}
// STR_SeparateOnCapitals (srcString) : results
// STR_SeparateOnCapitals (text): text
//
// DESCRIPTION
//   Splits a string into Words based on embeded capital letters.
//   For example: "onStartupMethod" becomes "on Startup Method".
//
C_TEXT:C284($1; $vt_srcString)
C_TEXT:C284($0; $vt_result)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/07/2012)
// ----------------------------------------------------

$vt_result:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_srcString:=$1
	
	C_LONGINT:C283($i)
	C_TEXT:C284($vt_theChar)
	For ($i; 1; Length:C16($vt_srcString))
		$vt_theChar:=$vt_srcString[[$i]]
		
		// If character is a capital letter
		If (Character code:C91($vt_theChar)>=Character code:C91("A")) & (Character code:C91($vt_theChar)<=Character code:C91("Z"))
			$vt_result:=$vt_result+" "
		End if 
		
		$vt_result:=$vt_result+$vt_theChar
	End for 
	
End if   // ASSERT
$0:=$vt_result