//%attributes = {"invisible":true}
// Component_Quit_Menu ()
// 
// DESCRIPTION
//   Quit the app
//
// ----------------------------------------------------

CONFIRM:C162("Are you sure you want to quit?"; "Yes"; "Cancel")
If (OK=1)
	QUIT 4D:C291
End if 