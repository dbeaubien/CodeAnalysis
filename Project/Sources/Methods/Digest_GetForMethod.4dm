//%attributes = {"invisible":true}
// Digest_GetForMethod (methodPath; ignoreAttributeLine; ignoreCase; ignoreMultipleSpaces) : methodDigest
// 
// DESCRIPTION
//   Returns a digest for the method by path.
//
#DECLARE($methodPath : Text\
; $ignoreAttributeLine : Boolean\
; $ignoreCase : Boolean\
; $ignoreMultipleSpaces : Boolean\
; $ignoreBlankLines : Boolean)->$methodDigest : Text
// ----------------------------------------------------
$methodDigest:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 5; Count parameters:C259))
	var $onErrorMethod : Text
	$onErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")
	
	var $methodContent : Text
	$methodContent:=Method_GetNormalizedCode($methodPath)  //   Mod by: Dani Beaubien (02/17/2014) - 
	
	If (OnErr_GetLastError#0)
		$methodContent:=""
	End if 
	
	$methodDigest:=Digest_GetForMethodText($methodContent; $ignoreAttributeLine; $ignoreCase; $ignoreMultipleSpaces; $ignoreBlankLines)
	
	OnErr_ClearError
	ON ERR CALL:C155($onErrorMethod)  // restore our method
End if 
