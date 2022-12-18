//%attributes = {"shared":true}
// CA_ShowAnalysisWindow ()
//
// DESCRIPTION
//   Opens the Code Analysis Window.
//
// This is the main entry point into this component.
//
// Calling this method opens the main code analysis dialog. From here you will be a
//  -Perform complexitiy analysis on the code in the host database.
//  -Preform a DIFF comparison of previously saved method code.
//  -Export method code to disk as text files.
//  -Export method documentation to disk as HTML.
//  -Export form properties to disk as JSON objects.
//
// NOTE: This method can only be used in an uncompiled host database
If (False:C215)
	// ----------------------------------------------------
	// HISTORY
	//   Created by: Dani Beaubien (9/19/12)
	//   Mod by: Dani Beaubien (10/01/2012) - Detect if compiled
	//   Mod by: Dani Beaubien (11/02/2012) - Renamed the method
	// ----------------------------------------------------
End if 

// NOTE: This method is shared with the host DB

If (Is compiled mode:C492(*))
	BEEP:C151
	ALERT:C41("This component can only be used in an uncompiled host database.")
	
Else 
	Component_init
	
	C_LONGINT:C283(<>_CodeAnalysis_ProcID)
	If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
		<>_CodeAnalysis_ProcID:=Current process:C322
		
		MethodStats_RecalculateModified
		
		C_POINTER:C301($NIL_p)
		WIN_Dialog($NIL_p; "Generator_d"; Plain window:K34:13; "Code Analysis Window"; On the left:K39:2; At the top:K39:5)
		
		<>_CodeAnalysis_ProcID:=0  // Clear our var
	End if 
End if 