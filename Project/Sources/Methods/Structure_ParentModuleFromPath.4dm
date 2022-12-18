//%attributes = {"invisible":true,"preemptive":"capable"}
// Structure_ParentModuleFromPath (methodPath) : parentModule
// Structure_ParentModuleFromPath (text) : text
//
// DESCRIPTION
//   Parses the method path and returns the text before
//   the first "_" as the parent module.
//   NOTE: leading "_" characters are ignored.
//
C_TEXT:C284($1; $methodPath)
C_TEXT:C284($0; $parentModule)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (09/07/2019)
// ----------------------------------------------------

$parentModule:=""
If (Asserted:C1132(Count parameters:C259=1))
	$methodPath:=$1
	
	// Figure out what the parent module is
	If ($methodPath#"[@")  // Not a form method
		C_TEXT:C284($vt_Pattern)
		$vt_Pattern:="(_)*[a-zA-Z0-9]+_"
		
		ARRAY TEXT:C222($at_tokens; 0)
		Tokenize__SplitExclusive($vt_Pattern; $methodPath+"_"; ->$at_tokens)
		
		If (Size of array:C274($at_tokens)>1)
			$parentModule:=$at_tokens{1}
		End if 
	End if 
	
End if 
$0:=$parentModule
