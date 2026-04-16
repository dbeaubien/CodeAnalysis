//%attributes = {"shared":true}
// CA_ShowQuickLauncher () 
// 
// DESCRIPTION
//   Opens the Quick Launcher floating palette window
//   that gives quick access to the features of CA.
//
If (False:C215)
	// ----------------------------------------------------
	// HISTORY
	//   Created by: DB (02/24/2014)
	// ----------------------------------------------------
End if 

// NOTE: This method is shared with the host DB

If (Is compiled mode:C492(*))
	// NOP - DO NOTHING
	
Else 
	Component_init
	
	var <>_CA_QuickLauncher_ProcID : Integer
	If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
		<>_CA_QuickLauncher_ProcID:=Current process:C322
		
		var $NIL_p : Pointer
		var $vl_winType : Integer
		$vl_winType:=0-Palette window:K34:3
		
		If (Pref_GetGlobalPrefString("QuickLauncher.IsFloating"; "Yes")="Yes")
			$vl_winType:=0-Palette window:K34:3
		Else 
			$vl_winType:=Palette window:K34:3
		End if 
		
		WIN_Dialog($NIL_p; "FloatingPalette"; $vl_winType; "Code Analysis"; On the right:K39:3; At the top:K39:5)
		
		<>_CA_QuickLauncher_ProcID:=0  // Clear our var
	End if 
End if 