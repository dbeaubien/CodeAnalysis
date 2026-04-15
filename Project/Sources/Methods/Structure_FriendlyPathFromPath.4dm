//%attributes = {"invisible":true,"preemptive":"capable"}
// Structure_FriendlyPathFromPath (methodPath) : friendlyMethodPath
//
// DESCRIPTION
//   Returns a user friendly version of the method path.
//   4D can URL encode some special characters, this
//   puts them back.
//
#DECLARE($methodPath : Text)->$friendlyMethodPath : Text
// ----------------------------------------------------
$friendlyMethodPath:=""

If (Asserted:C1132(Count parameters:C259=1))
	
	If (Position:C15("%"; $methodPath)>0)
		$friendlyMethodPath:=STR_URLDecode($methodPath)
	Else 
		$friendlyMethodPath:=$methodPath
	End if 
	
End if 
