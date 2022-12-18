//%attributes = {"invisible":true,"preemptive":"capable"}
// Structure_FriendlyPathFromPath (methodPath) : friendlyMethodPath
// Structure_FriendlyPathFromPath (text) : text
//
// DESCRIPTION
//   Returns a user friendly version of the method path.
//   4D can URL encode some special characters, this
//   puts them back.
//
C_TEXT:C284($1; $methodPath)
C_TEXT:C284($0; $friendlyMethodPath)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (09/07/2019)
// ----------------------------------------------------

$friendlyMethodPath:=""
If (Asserted:C1132(Count parameters:C259=1))
	$methodPath:=$1
	
	If (Position:C15("%"; $methodPath)>0)
		$friendlyMethodPath:=STR_URLDecode($methodPath)
	Else 
		$friendlyMethodPath:=$methodPath
	End if 
	
End if 
$0:=$friendlyMethodPath
