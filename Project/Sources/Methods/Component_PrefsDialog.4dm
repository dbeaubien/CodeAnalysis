//%attributes = {"invisible":true}
// Component_PrefsDialog
//
// DESCRIPTION
//   Opens the preference dialog
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (9/19/12)
// ----------------------------------------------------

If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	
	C_POINTER:C301($NIL_p)
	WIN_Dialog($NIL_p; "Preferences_d"; Plain window:K34:13; "Code Analysis Preferences"; On the left:K39:2; At the top:K39:5)
	
End if 