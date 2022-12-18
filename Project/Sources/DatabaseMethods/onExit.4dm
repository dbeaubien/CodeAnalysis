
If (Not:C34(Is compiled mode:C492))
	ARRAY TEXT:C222($at_components; 0)
	COMPONENT LIST:C1001($at_components)
	If (Find in array:C230($at_components; "Mainfest Generator")>0)
		EXECUTE METHOD:C1007("Manifest_RefreshLocalFile"; *)
	End if 
End if 
