//%attributes = {"invisible":true,"preemptive":"capable"}
// Folder_EnsureEndsInSeparator (path) : verifiedPath
// Folder_EnsureEndsInSeparator (text) : text
//
// DESCRIPTION
//   Ensures that the folder path ends in a folder separator.
//   Empty strings are ignored.
//
C_TEXT:C284($1)
C_TEXT:C284($0; $verifiedPath)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/15/2017)
// ----------------------------------------------------

$verifiedPath:=""
If (Asserted:C1132(Count parameters:C259=1))
	$verifiedPath:=$1
	
	If ($verifiedPath#"")
		If ($verifiedPath[[Length:C16($verifiedPath)]]#Folder separator:K24:12)  // make sure the path ends in a folder
			$verifiedPath:=$verifiedPath+Folder separator:K24:12
		End if 
	End if 
End if 
$0:=$verifiedPath