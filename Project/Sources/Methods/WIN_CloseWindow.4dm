//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: WIN_CloseWindow
// 
// DESCRIPTION:
//   This is a wrapper method for Close window. It also handles
//  saving of the size of the window if the user has requested
// ----------------------------------------------------
// PARAMETERS:
//   $1: reference to window to save
//   $2: layout name
// RETURNS:
//   none
// ----------------------------------------------------
// MODIFICATION HISTORY:
// Added by: jcraig (1/28/05) - 
// ----------------------------------------------------



If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	C_LONGINT:C283($1; $WIN_vl_windowRef)
	C_TEXT:C284($2; $WIN_vt_layoutName)
	$WIN_vl_windowRef:=$1
	$WIN_vt_layoutName:=$2
	
	// save the window position if the user has requested it.
	//If (Shift down)
	//Util_SaveWindowPosition ("UserPrefs";$WIN_vt_layoutName)
	Util_SaveWindowPosition("Disk"; $WIN_vt_layoutName)
	//End if 
	
	CLOSE WINDOW:C154($WIN_vl_windowRef)
End if   // ASSERT

