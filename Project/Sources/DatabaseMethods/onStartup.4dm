
//   Mod: DB (03/26/2017) - Set up my default prefs
CA_Pref_SetEOL(Char:C90(Line feed:K15:40))

//This code is available even if the component is not present like in the final application.
If (Not:C34(Is compiled mode:C492))
	ARRAY TEXT:C222($at_components; 0)
	COMPONENT LIST:C1001($at_components)
	If (Find in array:C230($at_components; "4DPop")>0)
		EXECUTE METHOD:C1007("4DPop_Palette")
	End if 
	
	C_LONGINT:C283($Window_lref)
	$Window_lref:=Open form window:C675("ReleaseBuildNo_d"; Regular window:K27:1; 420; 200)
	BRING TO FRONT:C326($Window_lref)
	DIALOG:C40("ReleaseBuildNo_d")
	CLOSE WINDOW:C154
	
	If (Find in array:C230($at_components; "Mainfest Generator")>0)
		EXECUTE METHOD:C1007("Manifest_SetAuthor"; *; "Dani Beaubien")
		EXECUTE METHOD:C1007("Manifest_SetBuildDate"; *; Current date:C33)
		EXECUTE METHOD:C1007("Manifest_SetURL"; *; "http://openroaddevelopment.com")
		EXECUTE METHOD:C1007("Manifest_SetCopyright"; *; "Copyright 2012-"+String:C10(Year of:C25(Current date:C33))+" Open Road Development inc. All rights reserved.")
		EXECUTE METHOD:C1007("Manifest_SetVersion"; *; BuildNo_GetBuildNo_CodeAnalysis.versionLong; True:C214)
	End if 
	
End if 

If (Is compiled mode:C492)
	ALERT:C41("ALERT: This is meant to be used as a 4D component. There is really nothing to do if you try to open it directly.")
Else 
	CA_OnStartup
End if 