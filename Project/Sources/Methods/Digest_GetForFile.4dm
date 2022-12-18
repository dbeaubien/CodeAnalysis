//%attributes = {"invisible":true}
// Digest_GetForFile (methodPath{; ignoreAttributeLine; ignoreCase; ignoreMultipleSpaces}) : methodDigest
// Digest_GetForFile (text{; boolean; boolean; boolean}) : methodDigest
// 
// DESCRIPTION
//   Returns a digest for the method by path.
//
C_TEXT:C284($1; $vt_filePath)
C_BOOLEAN:C305($2; $vb_ignoreAttributeLine)
C_BOOLEAN:C305($3; $vb_ignoreCase)
C_BOOLEAN:C305($4; $vb_ignoreMultipleSpaces)
C_BOOLEAN:C305($5; $vb_ignoreBlankLines)
C_TEXT:C284($0; $vt_methodDigest)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/10/2014)
// ----------------------------------------------------

$vt_methodDigest:=""
If (Asserted:C1132((Count parameters:C259=1) | (Count parameters:C259=5)))
	$vt_filePath:=$1
	If (Count parameters:C259=5)
		$vb_ignoreAttributeLine:=$2
		$vb_ignoreCase:=$3
		$vb_ignoreMultipleSpaces:=$4
		$vb_ignoreBlankLines:=$5
	End if 
	
	C_TEXT:C284($vt_onErrorMethod)  //   Mod by: Dani Beaubien (06/22/2013)
	$vt_onErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")  //   Mod by: Dani Beaubien (08/13/2013)
	
	
	// # Get the contents of the external file
	C_BLOB:C604($vx_methodBLOB)
	C_TEXT:C284($vt_methodContent)
	DOCUMENT TO BLOB:C525($vt_filePath; $vx_methodBLOB)
	$vt_methodContent:=Convert to text:C1012($vx_methodBLOB; "UTF-8")  // Methods will be saved as UTF-8 so I need to convert the 4D Text (UTF-16) to UTF-8...
	
	//   Mod by: Dani Beaubien (02/17/2014) - Convert the EOL to what we are using internally
	C_TEXT:C284($vt_EOL_Current)
	$vt_EOL_Current:=STR_TellMeTheEOL($vt_methodContent)
	If ($vt_EOL_Current#Pref_GetEOL)
		$vt_methodContent:=Replace string:C233($vt_methodContent; $vt_EOL_Current; Pref_GetEOL)
	End if 
	
	//   Mod: DB (12/17/2015) - Use a common method to get the digest
	$vt_methodDigest:=Digest_GetForMethodText($vt_methodContent; $vb_ignoreAttributeLine; $vb_ignoreCase; $vb_ignoreMultipleSpaces; $vb_ignoreBlankLines)
	
	OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
	ON ERR CALL:C155($vt_onErrorMethod)  // restore our method
End if   // ASSERT
$0:=$vt_methodDigest