//%attributes = {"invisible":true}
// Digest_GetForFile (methodPath{; ignoreAttributeLine; ignoreCase; ignoreMultipleSpaces}) : methodDigest
// 
// DESCRIPTION
//   Returns a digest for the method by path.
//
#DECLARE($vt_filePath : Text\
; $vb_ignoreAttributeLine : Boolean\
; $vb_ignoreCase : Boolean\
; $vb_ignoreMultipleSpaces : Boolean\
; $vb_ignoreBlankLines : Boolean)->$vt_methodDigest : Text
// ----------------------------------------------------
$vt_methodDigest:=""

If (Asserted:C1132((Count parameters:C259=1) | (Count parameters:C259=5)))
	var $vt_onErrorMethod : Text  //   Mod by: Dani Beaubien (06/22/2013)
	$vt_onErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")  //   Mod by: Dani Beaubien (08/13/2013)
	
	
	// # Get the contents of the external file
	var $vx_methodBLOB : Blob
	var $vt_methodContent : Text
	DOCUMENT TO BLOB:C525($vt_filePath; $vx_methodBLOB)
	$vt_methodContent:=Convert to text:C1012($vx_methodBLOB; "UTF-8")  // Methods will be saved as UTF-8 so I need to convert the 4D Text (UTF-16) to UTF-8...
	
	//   Mod by: Dani Beaubien (02/17/2014) - Convert the EOL to what we are using internally
	var $vt_EOL_Current : Text
	$vt_EOL_Current:=STR_TellMeTheEOL($vt_methodContent)
	If ($vt_EOL_Current#Pref_GetEOL)
		$vt_methodContent:=Replace string:C233($vt_methodContent; $vt_EOL_Current; Pref_GetEOL)
	End if 
	
	//   Mod: DB (12/17/2015) - Use a common method to get the digest
	$vt_methodDigest:=Digest_GetForMethodText($vt_methodContent; $vb_ignoreAttributeLine; $vb_ignoreCase; $vb_ignoreMultipleSpaces; $vb_ignoreBlankLines)
	
	OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
	ON ERR CALL:C155($vt_onErrorMethod)  // restore our method
End if 
