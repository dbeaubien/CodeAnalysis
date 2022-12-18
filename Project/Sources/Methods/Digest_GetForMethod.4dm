//%attributes = {"invisible":true}
// Digest_GetForMethod (methodPath; ignoreAttributeLine; ignoreCase; ignoreMultipleSpaces) : methodDigest
// Digest_GetForMethod (text; boolean; boolean; boolean) : methodDigest
// 
// DESCRIPTION
//   Returns a digest for the method by path.
//
C_TEXT:C284($1; $methodPath)
C_BOOLEAN:C305($2; $ignoreAttributeLine)
C_BOOLEAN:C305($3; $ignoreCase)
C_BOOLEAN:C305($4; $ignoreMultipleSpaces)
C_BOOLEAN:C305($5; $ignoreBlankLines)
C_TEXT:C284($0; $methodDigest)
// ----------------------------------------------------
// CALLED BY
//   CODE_doDiffOnFolder
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/10/2014)
// ----------------------------------------------------

$methodDigest:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 5; Count parameters:C259))
	$methodPath:=$1
	$ignoreAttributeLine:=$2
	$ignoreCase:=$3
	$ignoreMultipleSpaces:=$4
	$ignoreBlankLines:=$5
	
	C_TEXT:C284($onErrorMethod)
	$onErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")
	
	C_TEXT:C284($methodContent)
	$methodContent:=Method_GetNormalizedCode($methodPath)  //   Mod by: Dani Beaubien (02/17/2014) - 
	
	If (OnErr_GetLastError#0)
		$methodContent:=""
	End if 
	
	$methodDigest:=Digest_GetForMethodText($methodContent; $ignoreAttributeLine; $ignoreCase; $ignoreMultipleSpaces; $ignoreBlankLines)
	
	OnErr_ClearError
	ON ERR CALL:C155($onErrorMethod)  // restore our method
End if 
$0:=$methodDigest