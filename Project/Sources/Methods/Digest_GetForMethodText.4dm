//%attributes = {"invisible":true}
// Digest_GetForMethodText (methodContent; ignoreAttributeLine; ignoreCase; ignoreMultipleSpaces) : methodDigest
// Digest_GetForMethodText (text; boolean; boolean; boolean) : methodDigest
// 
// DESCRIPTION
//   Returns a digest for the method by path.
//
C_TEXT:C284($1; $methodContent)
var $2; $ignoreAttributeLine : Boolean
var $3; $ignoreCase : Boolean
var $4; $ignoreMultipleSpaces : Boolean
var $5; $ignoreBlankLines : Boolean
var $0; $methodDigest : Text
// ----------------------------------------------------
// CALLED BY
//   Digest_GetForFile, Digest_GetForMethod
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/17/2015)
// ----------------------------------------------------

$methodDigest:=""
If (Asserted:C1132(Count parameters:C259=5))
	$methodContent:=$1
	$ignoreAttributeLine:=$2
	$ignoreCase:=$3
	$ignoreMultipleSpaces:=$4
	$ignoreBlankLines:=$5
	
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
$0:=$methodDigest