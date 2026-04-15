//%attributes = {"invisible":true}
// Digest_GetForMethodText (methodContent; ignoreAttributeLine; ignoreCase; ignoreMultipleSpaces) : methodDigest
// 
// DESCRIPTION
//   Returns a digest for the method by path.
//
#DECLARE($methodContent : Text\
; $ignoreAttributeLine : Boolean\
; $ignoreCase : Boolean\
; $ignoreMultipleSpaces : Boolean\
; $ignoreBlankLines : Boolean)->$methodDigest : Text
// ----------------------------------------------------
$methodDigest:=""

If (Asserted:C1132(Count parameters:C259=5))
	var $onErrorMethod : Text  //   Mod by: Dani Beaubien (06/22/2013)
	$onErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")  //   Mod by: Dani Beaubien (08/13/2013)
	
	If ($ignoreAttributeLine)  //   Mod by: Dani Beaubien (10/04/2012)
		$methodContent:=MethodCode_RemoveAttributeLine($methodContent)
	End if 
	
	If ($ignoreCase)  // Added by: Dani Beaubien (10/25/2012)
		$methodContent:=Lowercase:C14($methodContent)
	End if 
	
	If ($ignoreMultipleSpaces)  // Added by: Dani Beaubien (10/25/2012)
		$methodContent:=Replace string:C233($methodContent; "  "; " ")
		$methodContent:=Replace string:C233($methodContent; "  "; " ")
		$methodContent:=Replace string:C233($methodContent; "  "; " ")
	End if 
	
	//   Mod: DB (12/17/2015) - Ignore blank lines
	If ($ignoreBlankLines)
		var $EOL : Text
		$EOL:=Pref_GetEOL
		$methodContent:=Replace string:C233($methodContent; Pref_GetEOL+Pref_GetEOL; Pref_GetEOL)
		$methodContent:=Replace string:C233($methodContent; Pref_GetEOL+Pref_GetEOL; Pref_GetEOL)
		$methodContent:=Replace string:C233($methodContent; Pref_GetEOL+Pref_GetEOL; Pref_GetEOL)
		$methodContent:=Replace string:C233($methodContent; Pref_GetEOL+Pref_GetEOL; Pref_GetEOL)
	End if 
	
	$methodDigest:=4D_GenerateDigest($methodContent)
	
	OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
	ON ERR CALL:C155($onErrorMethod)  // restore our method
End if 
