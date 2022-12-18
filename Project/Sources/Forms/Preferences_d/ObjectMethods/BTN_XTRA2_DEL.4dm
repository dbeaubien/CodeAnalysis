
If (at_XTRA_ignoreNames{at_XTRA_ignoreNames}#"")
	BEEP:C151
	CONFIRM:C162(Replace string:C233(Get localized string:C991("Msg_MTHD_ConfirmDelete"); "%1"; at_XTRA_ignoreNames{at_XTRA_ignoreNames}); Get localized string:C991("Btn_Delete"); Get localized string:C991("Btn_Cancel"))
	
	If (OK=1)
		DELETE FROM ARRAY:C228(at_XTRA_ignoreNames; at_XTRA_ignoreNames; 1)
		Pref_SetPrefTextArray("FileFolderNamesToIgnore"; ->at_XTRA_ignoreNames)
		
		If (Size of array:C274(at_XTRA_ignoreNames)=0)
			OBJECT SET ENABLED:C1123(*; "BTN_XTRA2_@"; False:C215)
		Else 
			// refresh our var
			If (at_XTRA_ignoreNames>Size of array:C274(at_XTRA_ignoreNames))
				at_XTRA_ignoreNames:=at_XTRA_ignoreNames-1
			End if 
		End if 
		
	End if 
End if 