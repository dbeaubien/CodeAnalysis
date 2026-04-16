//%attributes = {"invisible":true}
// WIN_CloseWindow
// 
// DESCRIPTION:
//   This is a wrapper method for Close window. It also handles
//   saving of the size of the window if the user has requested
// 
#DECLARE($WIN_vl_windowRef : Integer; $WIN_vt_layoutName : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	Util_SaveWindowPosition("Disk"; $WIN_vt_layoutName)
	
	CLOSE WINDOW:C154($WIN_vl_windowRef)
End if 

