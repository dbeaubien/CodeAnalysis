//%attributes = {"invisible":true}
// STR_SeparateOnCapitals (srcString) : results
//
// DESCRIPTION
//   Splits a string into Words based on embeded capital letters.
//   For example: "onStartupMethod" becomes "on Startup Method".
//
#DECLARE($vt_srcString : Text)->$vt_result : Text
// ----------------------------------------------------
$vt_result:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	var $i : Integer
	var $vt_theChar : Text
	For ($i; 1; Length:C16($vt_srcString))
		$vt_theChar:=$vt_srcString[[$i]]
		
		// If character is a capital letter
		If (Character code:C91($vt_theChar)>=Character code:C91("A")) & (Character code:C91($vt_theChar)<=Character code:C91("Z"))
			$vt_result:=$vt_result+" "
		End if 
		
		$vt_result:=$vt_result+$vt_theChar
	End for 
	
End if 
