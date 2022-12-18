
C_TEXT:C284($vt_newFolderPath)
$vt_newFolderPath:=Select folder:C670("Select the destination folder"; Folder_ParentName(Structure file:C489(*)))
If (OK=1)
	$vt_newFolderPath:=Folder_MakePathRelativeToStruct($vt_newFolderPath)
	Case of 
		: ($vt_newFolderPath="")
			BEEP:C151
			ALERT:C41(Get localized string:C991("Msg_FLDR_SelectFolder"))  // "You must select a folder that is a subfolder of the folder that the structure is in."
			
		: (Find in array:C230(at_XTRA_relativePaths; $vt_newFolderPath)>0)
			BEEP:C151
			ALERT:C41(Replace string:C233(Get localized string:C991("Msg_FLDR_AlreadyAdded"); "%1"; $vt_newFolderPath))  // "\""+$vt_newFolderPath+"\" has already been added."
			
		Else 
			APPEND TO ARRAY:C911(at_XTRA_relativePaths; $vt_newFolderPath)
			APPEND TO ARRAY:C911(at_XTRA_comparePathsFULL; "")
			APPEND TO ARRAY:C911(at_XTRA_actions; "Copy")
			SORT ARRAY:C229(at_XTRA_relativePaths; at_XTRA_comparePathsFULL; at_XTRA_actions; >)
			Pref_SetPrefTextArray("Extra Folder"; ->at_XTRA_relativePaths)
			Pref_SetPrefTextArray("Extra Folder CompareTo"; ->at_XTRA_comparePathsFULL)
			Pref_SetPrefTextArray("Extra Folder action"; ->at_XTRA_actions)
	End case 
	
End if 