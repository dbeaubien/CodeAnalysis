
If (at_XTRA_relativePaths{at_XTRA_relativePaths}#"")
	BEEP:C151
	CONFIRM:C162(Replace string:C233(Get localized string:C991("Msg_FLDR_ConfirmDelete"); "%1"; at_XTRA_relativePaths{at_XTRA_relativePaths}); Get localized string:C991("Btn_Delete"); Get localized string:C991("Btn_Cancel"))
	
	If (OK=1)
		C_LONGINT:C283($pos)
		$pos:=at_XTRA_relativePaths
		DELETE FROM ARRAY:C228(at_XTRA_relativePaths; $pos; 1)
		DELETE FROM ARRAY:C228(at_XTRA_comparePathsFULL; $pos; 1)
		DELETE FROM ARRAY:C228(at_XTRA_actions; $pos; 1)
		Pref_SetPrefTextArray("Extra Folder"; ->at_XTRA_relativePaths)
		Pref_SetPrefTextArray("Extra Folder CompareTo"; ->at_XTRA_comparePathsFULL)
		Pref_SetPrefTextArray("Extra Folder action"; ->at_XTRA_actions)
		
		If (Size of array:C274(at_XTRA_relativePaths)=0)
			OBJECT SET ENABLED:C1123(*; "BTN_XTRA_@"; False:C215)
			vt_fullPath:=""
		Else 
			// refresh our var
			If (at_XTRA_relativePaths>Size of array:C274(at_XTRA_relativePaths))
				at_XTRA_relativePaths:=at_XTRA_relativePaths-1
			End if 
			vt_fullPath:=Folder_GetPathFrmRelativeToStct(at_XTRA_relativePaths{at_XTRA_relativePaths})
		End if 
		
	End if 
End if 