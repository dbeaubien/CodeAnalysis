//%attributes = {"invisible":true,"preemptive":"capable"}
// Folder_EnsureEndsInSeparator (path) : verifiedPath
//
// DESCRIPTION
//   Ensures that the folder path ends in a folder separator.
//   Empty strings are ignored.
//
#DECLARE($folder_path : Text)->$verifiedPath : Text
// ----------------------------------------------------
$verifiedPath:=""

If (Asserted:C1132(Count parameters:C259=1))
	$verifiedPath:=$folder_path
	
	If ($verifiedPath#"")
		If ($verifiedPath[[Length:C16($verifiedPath)]]#Folder separator:K24:12)  // make sure the path ends in a folder
			$verifiedPath:=$verifiedPath+Folder separator:K24:12
		End if 
	End if 
End if 
