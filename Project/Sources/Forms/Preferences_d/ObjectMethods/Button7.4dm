
C_TEXT:C284($vt_newValue)
$vt_newValue:=Request:C163(Get localized string:C991("Msg_MTHD_AddNameToList"); ""; Get localized string:C991("Btn_Add"); Get localized string:C991("Btn_Cancel"))
If (OK=1)
	Case of 
		: ($vt_newValue="")
			BEEP:C151
			
		: (Find in array:C230(at_XTRA_ignoreNames; $vt_newValue)>0)
			BEEP:C151
			ALERT:C41(Replace string:C233(Get localized string:C991("Msg_FLDR_AlreadyAdded"); "%1"; $vt_newValue))
			
		Else 
			APPEND TO ARRAY:C911(at_XTRA_ignoreNames; $vt_newValue)
			SORT ARRAY:C229(at_XTRA_ignoreNames; >)
			Pref_SetPrefTextArray("FileFolderNamesToIgnore"; ->at_XTRA_ignoreNames)
	End case 
	
End if 