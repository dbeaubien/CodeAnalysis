//%attributes = {"invisible":true,"preemptive":"capable"}
// Structure_ParentModuleFromPath (methodPath) : parentModule
//
// DESCRIPTION
//   Parses the method path and returns the text before
//   the first "_" as the parent module.
//   NOTE: leading "_" characters are ignored.
//
#DECLARE($methodPath : Text)->$parentModule : Text
// ----------------------------------------------------
$parentModule:=""

If (Asserted:C1132(Count parameters:C259=1))
	
	// Figure out what the parent module is
	If ($methodPath#"[@")  // Not a form method
		var $vt_Pattern : Text
		$vt_Pattern:="(_)*[a-zA-Z0-9]+_"
		
		ARRAY TEXT:C222($at_tokens; 0)
		Tokenize__SplitExclusive($vt_Pattern; $methodPath+"_"; ->$at_tokens)
		
		If (Size of array:C274($at_tokens)>1)
			$parentModule:=$at_tokens{1}
		End if 
	End if 
	
End if 
