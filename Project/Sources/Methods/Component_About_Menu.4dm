//%attributes = {"invisible":true}
// Component_About_Menu
//
// DESCRIPTION
//   Show the About dialog (on preferences)
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/05/2012)
// ----------------------------------------------------

C_BOOLEAN:C305(<>ShowAboutPage)
<>ShowAboutPage:=True:C214

If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	Component_PrefsDialog
End if 