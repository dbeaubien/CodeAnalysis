//%attributes = {"invisible":true}
// WIN_Dialog (..)
//  
// DESCRIPTION:
//   This is a wrapper method for handling dialogs. restoring and saving
//   of window positions is handled. 
//  
// Parameters
// ----------------------------------------------------
//   $1: pointer to the table of the layout
//   $2: name of the layout
//   $3: window type
//   $4: Window Title
//   $5: horz positioning
//   $6: vert positioning
#DECLARE($WIN_vl_tablePtr : Pointer\
; $WIN_vt_layoutName : Text\
; $WIN_vl_windowType : Integer\
; $WIN_vT_WindowTitle : Text\
; $WIN_vl_horzPos : Integer\
; $WIN_vl_vertPos : Integer\
; $WIN_vF_DontUseSaved : Boolean)
// ----------------------------------------------------
If (Count parameters:C259<5)
	$WIN_vl_horzPos:=On the left:K39:2
End if 
If (Count parameters:C259<6)
	$WIN_vl_vertPos:=At the top:K39:5
End if 

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 3; 7; Count parameters:C259))
	var $vL_OK : Integer
	
	Component_init
	
	var $WIN_vl_width; $WIN_vl_height : Integer
	
	// If the window size has been saved to disk, then make sure that it is not too small
	// the layout might have been resized, so just double check
	If (Is nil pointer:C315($WIN_vl_tablePtr))
		FORM GET PROPERTIES:C674($WIN_vt_layoutName; $WIN_vl_width; $WIN_vl_height)
	Else 
		FORM GET PROPERTIES:C674($WIN_vl_tablePtr->; $WIN_vt_layoutName; $WIN_vl_width; $WIN_vl_height)
	End if 
	
	If ((WIN_PositionHasBeenSaved($WIN_vt_layoutName; "Disk")) & (Not:C34($WIN_vF_DontUseSaved)))
		WIN_PositionFromDisk($WIN_vt_layoutName; $WIN_vl_width; $WIN_vl_height; "notOpenYet"; "UserPrefs")
		var $RefWindow : Integer
		$RefWindow:=Open window:C153(WIN_left_l; WIN_top_l; WIN_right_l; WIN_bottom_l; $WIN_vl_windowType; $WIN_vT_WindowTitle; "WIN_HandleCloseWindow_EMPTY")
		
	Else 
		Case of 
			: ($WIN_vl_horzPos=Horizontally centered:K39:1)
				WIN_left_l:=(Screen width:C187(*)/2)-($WIN_vl_width/2)
				WIN_right_l:=WIN_left_l+$WIN_vl_width
			: ($WIN_vl_horzPos=On the left:K39:2)
				WIN_left_l:=5
				WIN_right_l:=WIN_left_l+$WIN_vl_width
			: ($WIN_vl_horzPos=On the right:K39:3)
				WIN_right_l:=Screen width:C187(*)-5
				WIN_left_l:=WIN_right_l-$WIN_vl_width
			Else 
				WIN_left_l:=(Screen width:C187(*)/2)-($WIN_vl_width/2)
				WIN_right_l:=WIN_left_l+$WIN_vl_width
		End case 
		
		Case of 
			: ($WIN_vl_vertPos=Vertically centered:K39:4)
				WIN_top_l:=((Screen height:C188(*)/2)+(Menu bar height:C440/2))-($WIN_vl_height/2)
				WIN_bottom_l:=WIN_top_l+$WIN_vl_height
			: ($WIN_vl_vertPos=At the top:K39:5)
				WIN_top_l:=Menu bar height:C440+Tool bar height:C1016+30
				WIN_bottom_l:=WIN_top_l+$WIN_vl_height
			: ($WIN_vl_vertPos=At the bottom:K39:6)
				WIN_bottom_l:=Screen height:C188(*)-5
				WIN_top_l:=WIN_bottom_l-$WIN_vl_height
			Else 
				WIN_top_l:=((Screen height:C188(*)/2)+(Menu bar height:C440/2))-($WIN_vl_height/2)
				WIN_bottom_l:=WIN_top_l+$WIN_vl_height
				
		End case 
		$RefWindow:=Open window:C153(WIN_left_l; WIN_top_l; WIN_right_l; WIN_bottom_l; $WIN_vl_windowType; $WIN_vT_WindowTitle; "WIN_HandleCloseWindow_EMPTY")
	End if 
	
	If ($RefWindow#0)
		SET WINDOW TITLE:C213(CA_Get_StructureName+": "+$WIN_vT_WindowTitle)
		WIN_EnsureOnScreen($RefWindow)
		
		//OT_Window_Set($WIN_vl_processObjID;$WIN_vl_tablePtr;$RefWindow;$WIN_vt_layoutName;$WIN_vT_WindowTitle)
		//Fnd_Menu_Window_Add
		If (Is nil pointer:C315($WIN_vl_tablePtr))
			DIALOG:C40($WIN_vt_layoutName)
		Else 
			DIALOG:C40($WIN_vl_tablePtr->; $WIN_vt_layoutName)
		End if 
		//Fnd_Menu_Window_Remove
		$vL_OK:=OK  // Added by: johncraig (8/24/06), 09:31:47
		//We want the OK system variable to be carried through to the end of the method. 
		//ObjectTools messes with the OK variable, so we need to 'carry it around' to the end of the method and reset it
		//OT_Window_Close($WIN_vl_processObjID;$RefWindow)
		WIN_CloseWindow($RefWindow; $WIN_vt_layoutName)
		OK:=$vL_OK
	Else 
		//Fnd_Dlg_SetIcon(Fnd_Dlg_WarnIcon)
		//Fnd_Dlg_Alert("An unexpected error occured. Could not open the desired window.")
		ALERT:C41("An unexpected error occured. Could not open the desired window.")
	End if 
End if 
